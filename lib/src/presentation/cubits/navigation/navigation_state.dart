part of 'navigation_cubit.dart';

enum NavigationStatus { initial, loading, success, failure }

extension NavigationStateX on NavigationStatus {
  bool get isInitial => this == NavigationStatus.initial;
  bool get isLoading => this == NavigationStatus.loading;
  bool get isSuccess => this == NavigationStatus.success;
  bool get isError => this == NavigationStatus.failure;
}

class NavigationState extends Equatable {
  final NavigationStatus? status;
  //CONTROLLERS
  final MapController? mapController;
  final CarouselController? carouselController;
  //LISTS
  final List<dynamic>? works;
  final List<PolylineLayer>? layer;
  final List<Marker>? markers;
  final List<LatLng>? kWorkList;
  final List<Map>? carouselData;
  final List<LayerMoodle>? model;
  final List<Polyline>? polylines;
  final GlobalKey? key;
  final bool infoWindowVisible;
  //VARIABLES
  final double? rotation;
  final int? pageIndex;
  final String? error;

  const NavigationState(
      {this.status,
      this.works,
      this.mapController,
      this.rotation,
      this.carouselController,
      this.layer,
      this.markers,
      this.kWorkList,
      this.carouselData,
      this.model,
      this.polylines,
      this.key,
      this.infoWindowVisible = false,
      this.pageIndex,
      this.error});

  @override
  List<Object?> get props => [
        status,
        works,
        mapController,
        carouselController,
        rotation,
        layer,
        markers,
        kWorkList,
        carouselData,
        model,
        polylines,
        key,
        infoWindowVisible,
        pageIndex,
        error
      ];

  NavigationState copyWith({
    NavigationStatus? status,
    MapController? mapController,
    CarouselController? carouselController,
    List<dynamic>? works,
    List<PolylineLayer>? layer,
    List<LatLng>? kWorkList,
    List<Marker>? markers,
    List<Polyline>? polylines,
    List<Map>? carouselData,
    List<LayerMoodle>? model,
    GlobalKey? key,
    bool? infoWindowVisible,
    double? rotation,
    int? pageIndex,
    String? error,
  }) {
    return NavigationState(
      status: status ?? this.status,
      mapController: mapController ?? this.mapController,
      carouselController: carouselController ?? this.carouselController,
      works: works ?? this.works,
      layer: layer ?? this.layer,
      kWorkList: kWorkList ?? this.kWorkList,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      carouselData: carouselData ?? this.carouselData,
      model: model ?? this.model,
      rotation: rotation ?? this.rotation,
      key: key ?? this.key,
      infoWindowVisible: infoWindowVisible ?? this.infoWindowVisible,
      pageIndex: pageIndex ?? this.pageIndex,
      error: error ?? this.error,
    );
  }
}
