class GoogleMapsRequest {
  final String latitude;
  final String longitude;
  final String radius;
  final String apiKey;

  GoogleMapsRequest(
      {required this.latitude,
      required this.longitude,
      required this.radius,
      required this.apiKey});
}
