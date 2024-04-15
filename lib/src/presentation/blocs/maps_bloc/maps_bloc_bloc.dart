import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_car_list_on_map.dart';
import 'package:bexmovil/src/utils/resources/app_dialogs.dart';
import 'package:bexmovil/src/utils/widget_to_marker.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_bloc_event.dart';
part 'maps_bloc_state.dart';

CarouselController carouselController = CarouselController();

class MapsBloc extends Bloc<MapsBlocEvent, MapsBlocState> {
  GoogleMapController? _mapController;

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
    // List<CardClientListOnMap>? listClients = [];
    Map<String, Marker> currentMarkers = {};

    for (int i = 0; i < event.clients.length; i++) {
      Client client = event.clients[i];

      BitmapDescriptor clientMarker = await getfinalCustomMarkerOrigin(
          index: (i + 1).toString(), context: event.context);
      final clienMarker = Marker(
        onTap: () {
          showClientDialog(context: event.context, client: client);
        },
        markerId: MarkerId(client.name!.toString()),
        position: LatLng(double.parse(client.latitude ?? '0'),
            double.parse(client.longitude ?? '0')),
        icon: clientMarker,
        anchor: const Offset(0.1, 1),
      );
      currentMarkers[client.name.toString()] = clienMarker;

      // listClients.add(CardClientListOnMap(client: client));
    }

    /*    for (Client client in event.clients) {

      BitmapDescriptor clientMarker = await getfinalCustomMarkerOrigin(
          index: '8',
          context: event.context);
      final clienMarker = Marker(
        markerId: MarkerId(client.name!.toString()),
        position: LatLng(double.parse(client.latitude ?? '0'),
            double.parse(client.longitude ?? '0')),
        icon: clientMarker,
        anchor: const Offset(0.1, 1),
      );
      currentMarkers[client.name.toString()] = clienMarker;


    //  listClients.add(CardClientListOnMap(client: client));
    }
 */
    _mapController = event.controller;
    // _mapController!.setMapStyle(jsonEncode(uberMapTheme))

    emit(state.copyWith(
        isMapInitialized: true,
        disposeMapController: false,
        /*     listClients: listClients,
        clientsFounded: listClients, */
        markers: currentMarkers));
  }

  void _searchClient(SearchClient event, Emitter emit) {
    /*    List<CardClientListOnMap>? clientsFounded = [];
    clientsFounded = buscarClientes(event.valueToSearch);
    print('value');
    emit(state.copyWith(clientsFounded: clientsFounded)); */
  }

/*   List<CardClientListOnMap>? buscarClientes(String valor) {
    if (valor == '') {
      return state.listClients!;
    }

    return state.listClients!.where((cardClient) {
      // Verifica si el nombre o el código del cliente dentro del widget coinciden con el valor proporcionado.
      return cardClient.client.name!.toLowerCase().contains(valor) ||
          cardClient.client.businessName!.toLowerCase().contains(valor);
    }).toList();
  } */

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

/*   void _onCarouselPageChanged(
      OnCarouselPageChanged event, Emitter<MapsBlocState> emit) async {
    String? latitude = state.clientsFounded![event.index].client.latitude;
    String? longitude = state.clientsFounded![event.index].client.longitude;

    if (latitude != null &&
        latitude != '' &&
        longitude != null &&
        longitude != '') {
      await (moverCamera(
          LatLng(double.parse(latitude), double.parse(longitude))));
    }

    emit(state.copyWith(
        selectedClient: state.clientsFounded![event.index].client));
  } */

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
}
