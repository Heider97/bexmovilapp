class GoogleRequest {
  final String username;
  final String password;
  final String? deviceId;
  final String? model;
  final String? version;
  final String? date;
  final String? latitude;
  final String? longitude;

  GoogleRequest(
    this.username, 
    this.password, 
    this.deviceId, 
    this.model, 
    this.version, 
    this.date, 
    this.latitude, 
    this.longitude,
  );
}