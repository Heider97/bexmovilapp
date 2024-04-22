import 'dart:convert';

import 'package:bexmovil/src/config/theme/uber_map_theme.dart';
import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_car_list_on_map.dart';
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

  MapsBloc() : super(const MapsBlocState()) {
    on<MapsBlocEvent>((event, emit) {});
    on<OnMapInitializedEvent>(_onInitMap);
    on<StopMapControllerEvent>(_onEndMap);
    on<SearchClient>(_searchClient);
    on<SelectClient>(_selectClient);
    //  on<OnCarouselPageChanged>(_onCarouselPageChanged);
    on<UnSelectClient>(_unSelectClient);
    on<CenterToUserLocation>(_centerToUserLocation);
  }

  Future moverCamera(LatLng newLocation) async {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    if (_mapController != null) {
      await _mapController?.animateCamera(cameraUpdate);
    }
  }

  void _onInitMap(
      OnMapInitializedEvent event, Emitter<MapsBlocState> emit) async {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    ThemeData theme = Theme.of(event.context);
    final Position myCurrentPosition = await Geolocator.getCurrentPosition();

    LatLng currentPosition =
        LatLng(myCurrentPosition.latitude, myCurrentPosition.longitude);

    //UBICAR EL MAPA EN LA POCICION DEL USUARIO
    moverCamera(currentPosition);

    //DIBUJO LAS POLYLINES
    await drawPolylines(
        theme: theme, codeRouter: event.codeRouter, clients: event.clients);

    //DIBUJO LOS MARCADORES
    await drawMarkers(
        context: event.context,
        currentPosition: currentPosition,
        clients: event.clients);

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
    final Position position = await Geolocator.getCurrentPosition();

    double latitude = position.latitude;
    double longitude = position.longitude;

    await (moverCamera(LatLng(latitude, longitude)));
  }

  drawPolylines(
      {required ThemeData theme,
      required String codeRouter,
      required List<Client> clients}) async {
//TODO: primero debo revisar que el codeRouter no este en la tabla de las polylines,
//TODO: Ahora tengo revisar que tenga conexion a internet para hacer la peticion normal o por cola de procesamiento
//TODO: SI Tengo internet HACER LA PETICION Y ALMACENAR LOS DATOS EN LA BASE DE DATOS de polylines.
//TODO: SI NO tengo INTERNET REVISAR QUE NO HAYA OTRA PETICION IGUAL EN LA COLA Y ENVIARLA Y ALMACENAR LOS DATOS EN LA BASE DE DATOS de polylines.

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
      /*  List<LngLat> waypoints = [
        LngLat(lat: 6.2688216, lng: -75.5603171),
        LngLat(lat: 6.2640998, lng: -75.5582004)
      ]; */

      final manager = OSRMManager()
        ..generatePath("https://osrm.bexsoluciones.com", waypoints.toString());

      final road = await manager.getRoad(
        waypoints: waypoints,
        geometries: Geometries.geojson,
        steps: true,
        language: Languages.en,
      );

      print(road);

      currentPolyline['poly'] = Polyline(
          endCap: Cap.roundCap,
          width: 3,
          color: Colors.blue[400]!,
          polylineId: PolylineId('1'),
          points: road.polyline!.map((lngLat) {
            return LatLng(lngLat.lat, lngLat.lng);
          }).toList());
    }
  }

  drawMarkers(
      {required BuildContext context,
      required LatLng currentPosition,
      required List<Client> clients}) async {
    late BitmapDescriptor clientMarker;
    if (context.mounted) {
      clientMarker = await getMyLocationMarker(context: context);
    }

    final myPositionMarker = Marker(
      markerId: const MarkerId('MyLocationMarker'),
      position: currentPosition,
      icon: clientMarker,
      anchor: const Offset(0.1, 1),
    );

    for (int i = 0; i < clients.length; i++) {
      Client client = clients[i];

      BitmapDescriptor clientMarker = await getfinalCustomMarkerOrigin(
          index: (i + 1).toString(), context: context);
      final clienMarker = Marker(
        onTap: () {
          showClientDialog(context: context, client: client);
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
  }
}
