import 'dart:convert';

import 'package:bexmovil/src/config/theme/uber_map_theme.dart';
import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/gps/gps_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/location/location_bloc.dart';

import 'package:bexmovil/src/utils/resources/app_dialogs.dart';
import 'package:bexmovil/src/utils/widget_to_marker.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

part 'maps_bloc_event.dart';
part 'maps_bloc_state.dart';

CarouselController carouselController = CarouselController();
final DatabaseRepository databaseRepository = locator<DatabaseRepository>();

class MapsBloc extends Bloc<MapsBlocEvent, MapsBlocState> {
  GoogleMapController? _mapController;

  Map<String, Marker> currentMarkers = {};
  Map<String, Polyline> currentPolyline = {};

  late LocationBloc locationBloc;

  MapsBloc() : super(const MapsBlocState()) {
    on<MapsBlocEvent>((event, emit) {});
    on<OnMapInitializedEvent>(_onInitMap);
    on<StopMapControllerEvent>(_onEndMap);
    on<SearchClient>(_searchClient);
    on<SelectClient>(_selectClient);
    //  on<OnCarouselPageChanged>(_onCarouselPageChanged);
    on<UnSelectClient>(_unSelectClient);
    on<CenterToUserLocation>(_centerToUserLocation);
    on<MoveToClientLocation>(_moveToClientLocation);
  }

  _moveToClientLocation(MoveToClientLocation evemt, Emitter emit) async {
    await moverCamera(state.markers.values.first.position);
  }

  Future moverCamera(LatLng newLocation) async {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    if (_mapController != null) {
      await _mapController?.animateCamera(cameraUpdate);
    }
  }

  void _onInitMap(
      OnMapInitializedEvent event, Emitter<MapsBlocState> emit) async {
    locationBloc = event.locationBloc;
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    ThemeData theme = Theme.of(event.context);
    currentMarkers = {};
    currentPolyline = {};
    emit(state.copyWith(
        gettingMarkers: true,
        gettingPolylines: true,
        markers: currentMarkers,
        polylines: currentPolyline));

    //final LatLng? myCurrentPosition = gpsBloc.lastRecordedLocation;
/*
    LatLng currentPosition =
        LatLng(myCurrentPosition.latitude, myCurrentPosition.longitude); */
    LatLng position = LatLng(
        locationBloc.state.lastKnownLocation?.latitude ?? 0,
        locationBloc.state.lastKnownLocation?.longitude ?? 0);
    //UBICAR EL MAPA EN LA POCICION DEL USUARIO
    moverCamera(position);

    //DIBUJO LAS POLYLINES
    await drawPolylines(
        theme: theme,
        codeRouter: event.codeRouter,
        clients: event.clients,
        emitter: emit);

    //DIBUJO LOS MARCADORES
    await drawMarkers(
        context: event.context,
        currentPosition: position,
        clients: event.clients,
        emitter: emit);

    emit(state.copyWith(
        isMapInitialized: true,
        disposeMapController: false,
        markers: currentMarkers,
        polylines: currentPolyline));
  }

  void _searchClient(SearchClient event, Emitter emit) {}

  void _selectClient(SelectClient event, Emitter emit) {
    Map<String, Marker> currentMarkers = {};
    String? latitude = event.client.latitude;
    String? longitude = event.client.longitude;

    if (event.client.id != null &&
        latitude != null &&
        latitude != '' &&
        longitude != null &&
        longitude != '') {
      final locationMarker = Marker(
        markerId: MarkerId(event.client.id.toString()),
        position: LatLng(double.parse(latitude), double.parse(longitude)),
      );
      currentMarkers[event.client.id!.toString()] = locationMarker;
    }

    emit(state.copyWith(selectedClient: event.client, markers: currentMarkers));
  }

  void _onEndMap(StopMapControllerEvent event, Emitter<MapsBlocState> emit) {
    _mapController?.dispose();
    emit(state.copyWith(disposeMapController: true));
  }

  void _unSelectClient(UnSelectClient event, Emitter<MapsBlocState> emit) {
    emit(state.copyWith(selectedClient: null));
  }

  void _centerToUserLocation(
      CenterToUserLocation event, Emitter<MapsBlocState> emit) async {
    double latitude = locationBloc.state.lastKnownLocation?.latitude ?? 0;
    double longitude = locationBloc.state.lastKnownLocation?.longitude ?? 0;

    await (moverCamera(LatLng(latitude, longitude)));
  }

  drawPolylines(
      {required ThemeData theme,
      required String codeRouter,
      required List<Client> clients,
      required Emitter emitter}) async {

    List<LatLng> polylines = await databaseRepository.getPolyline(codeRouter);

    if (polylines.isNotEmpty) {
    } else {
      List<LngLat> waypoints = clients
          .where(
              (client) => client.latitude != null && client.longitude != null)
          .map((client) {
        double lat = double.parse(client.latitude!);
        double lng = double.parse(client.longitude!);
        return LngLat(lat: lat, lng: lng);
      }).toList();

      final manager = OSRMManager()
        ..generatePath("https://osrm.bexsoluciones.com", waypoints.toString());

      final road = await manager.getRoad(
        waypoints: waypoints,
        geometries: Geometries.geojson,
        steps: true,
        language: Languages.en,
      );

      currentPolyline['poly'] = Polyline(
          endCap: Cap.roundCap,
          width: 3,
          color: Colors.blue[400]!,
          polylineId: const PolylineId('1'),
          points: road.polyline!.map((lngLat) {
            return LatLng(lngLat.lat, lngLat.lng);
          }).toList());
    }
    emitter(state.copyWith(gettingPolylines: false));
  }

  drawMarkers(
      {required BuildContext context,
      required LatLng currentPosition,
      required List<Client> clients,
      required Emitter emitter}) async {
    currentMarkers = {};

    late BitmapDescriptor clientMarker;
    if (context.mounted) {
      clientMarker = await getMyLocationMarker(context: context);
    }

    if (locationBloc.state.lastKnownLocation == null) {
      await locationBloc.getCurrentPosition();
    }

    final myPositionMarker = Marker(
      markerId: const MarkerId('MyLocationMarker'),
      position: LatLng(locationBloc.state.lastKnownLocation!.latitude,
          locationBloc.state.lastKnownLocation!.longitude),
      icon: clientMarker,
      anchor: const Offset(0.1, 1),
    );

    for (int i = 0; i < clients.length; i++) {
      Client client = clients[i];

      BitmapDescriptor clientMarker = await getfinalCustomMarkerOrigin(
          index: (i + 1).toString(),
          context: context,
          type: clients[i].typeClient == 'client' ? false : true);
      final clienMarker = Marker(
        onTap: () {
          // showClientDialog(context: context, client: client);
        },
        markerId: MarkerId(client.name!.toString()),
        position: LatLng(double.parse(client.latitude ?? '0'),
            double.parse(client.longitude ?? '0')),
        icon: clientMarker,
        anchor: const Offset(0.1, 1),
      );

      currentMarkers[client.name.toString()] = clienMarker;
    }
    currentMarkers['MyLocationMarker'] = myPositionMarker;

    emitter(state.copyWith(gettingMarkers: false));
  }
}
