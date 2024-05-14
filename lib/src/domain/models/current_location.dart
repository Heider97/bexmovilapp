class CurrentUserLocation {
  const CurrentUserLocation({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;

  static const empty = CurrentUserLocation(latitude: 0, longitude: 0);
}