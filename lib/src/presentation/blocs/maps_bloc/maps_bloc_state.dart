part of 'maps_bloc_bloc.dart';

class MapsBlocState {
  final bool isMapInitialized;
  final bool disposeMapController;
  final CarouselController? carouselController;
  final Map<String, Marker> markers;
/*   final List<CardClientListOnMap>? listClients;
  final List<CardClientListOnMap>? clientsFounded; */
  final Client? selectedClient;

  const MapsBlocState({
    this.isMapInitialized = false,
    this.disposeMapController = false,
    this.carouselController,
/*     this.listClients,
    this.clientsFounded, */
    this.selectedClient,
    Map<String, Marker>? markers,
  }) : markers = markers ?? const {};

  MapsBlocState copyWith({
    Map<String, Marker>? markers,
    bool? isMapInitialized,
    bool? disposeMapController,
    CarouselController? carouselController,
/*     List<CardClientListOnMap>? listClients,
    List<CardClientListOnMap>? clientsFounded, */
    Client? selectedClient,
  }) =>
      MapsBlocState(
        markers: markers ?? this.markers,
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        disposeMapController: disposeMapController ?? this.disposeMapController,
        carouselController: carouselController ?? this.carouselController,
  /*       listClients: listClients ?? this.listClients,
        clientsFounded: clientsFounded ?? this.clientsFounded, */
        selectedClient: selectedClient,
      );
}
