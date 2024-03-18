import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_car_list_on_map.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<OnCarouselPageChanged>(_onCarouselPageChanged);
    on<UnSelectClient>(_unSelectClient);
  }

  Future moverCamera(LatLng newLocation) async {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    if (_mapController != null) {
      await _mapController?.moveCamera(cameraUpdate);
    }
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapsBlocState> emit) {
    List<CardClientListOnMap>? listClients = [];

    for (Client client in event.clients) {
      listClients.add(CardClientListOnMap(client: client));
    }

    _mapController = event.controller;
    // _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(
        isMapInitialized: true,
        disposeMapController: false,
        listClients: listClients,
        clientsFounded: listClients));
  }

  void _searchClient(SearchClient event, Emitter emit) {
    List<CardClientListOnMap>? clientsFounded = [];
    clientsFounded = buscarClientes(event.valueToSearch);
    print('value');
    emit(state.copyWith(clientsFounded: clientsFounded));
  }

  List<CardClientListOnMap>? buscarClientes(String valor) {
    if (valor == '') {
      return state.listClients!;
    }

    return state.listClients!.where((cardClient) {
      // Verifica si el nombre o el código del cliente dentro del widget coinciden con el valor proporcionado.
      return cardClient.client.name!.toLowerCase().contains(valor) ||
          cardClient.client.businessName!.toLowerCase().contains(valor);
    }).toList();
  }

  void _selectClient(SelectClient event, Emitter emit) {
    emit(state.copyWith(selectedClient: event.client));
  }

  void _onEndMap(StopMapControllerEvent event, Emitter<MapsBlocState> emit) {
    _mapController?.dispose();
    emit(state.copyWith(disposeMapController: true));
  }

  void _onCarouselPageChanged(
      OnCarouselPageChanged event, Emitter<MapsBlocState> emit) async {
    //await (moverCamera(location));

    emit(state.copyWith(
        selectedClient: state.clientsFounded![event.index].client));
  }

  void _unSelectClient(UnSelectClient event, Emitter<MapsBlocState> emit) {
    emit(state.copyWith(selectedClient: null));
  }
}
