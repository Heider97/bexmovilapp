part of 'maps_bloc_bloc.dart';

class MapsBlocEvent {
  const MapsBlocEvent();
}

class OnMapInitializedEvent extends MapsBlocEvent {
  final GoogleMapController controller;
  final BuildContext context;
  final List<Client> clients;
  const OnMapInitializedEvent(this.controller, this.clients, this.context);
}

class StopMapControllerEvent extends MapsBlocEvent {}

class SearchClient extends MapsBlocEvent {
  final String valueToSearch;
  SearchClient({required this.valueToSearch});
}

class SelectClient extends MapsBlocEvent {
  final Client client;
  SelectClient({required this.client});
}

class UnSelectClient extends MapsBlocEvent {
  UnSelectClient();
}

class OnCarouselPageChanged extends MapsBlocEvent {
  final int index;
  OnCarouselPageChanged({required this.index});
}

class CenterToUserLocation extends MapsBlocEvent {
  CenterToUserLocation();
}
