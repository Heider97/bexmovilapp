part of 'maps_bloc_bloc.dart';

class MapsBlocState {
  final bool isMapInitialized;
  final bool disposeMapController;
  final CarouselController? carouselController;
  final Map<String, Marker> markers;
  final Map<String, Polyline> polylines;
  final Client? selectedClient;
  final bool gettingMarkers;
  final bool gettingPolylines;

  const MapsBlocState({
    this.isMapInitialized = false,
    this.disposeMapController = false,
    this.carouselController,
    this.selectedClient,
    this.gettingMarkers = false,
    this.gettingPolylines = false,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {};

  MapsBlocState copyWith(
          {Map<String, Marker>? markers,
          Map<String, Polyline>? polylines,
          bool? isMapInitialized,
          bool? disposeMapController,
          CarouselController? carouselController,
          Client? selectedClient,
          bool? gettingMarkers,
          bool? gettingPolylines}) =>
      MapsBlocState(
          markers: markers ?? this.markers,
          polylines: polylines ?? this.polylines,
          isMapInitialized: isMapInitialized ?? this.isMapInitialized,
          disposeMapController:
              disposeMapController ?? this.disposeMapController,
          carouselController: carouselController ?? this.carouselController,
          selectedClient: selectedClient,
          gettingMarkers: gettingMarkers ?? this.gettingMarkers,
          gettingPolylines: gettingPolylines ?? this.gettingPolylines);
}
