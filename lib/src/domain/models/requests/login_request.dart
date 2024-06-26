//TODO: [Felipe Bedoya] ADD DEVICE_ID,MODEL,DATE,LAT,LNG TO WILL SEND VIA API

class LoginRequest {
  final String username;
  final String password;
  final String? deviceId;
  final String? model;
  final String? version;
  final String? date;
  final String? latitude;
  final String? longitude;

  LoginRequest(this.username, this.password, this.deviceId, this.model,
      this.version, this.date, this.latitude, this.longitude);

  Map toMap() {
    return {
      'email': username,
      'password': password,
      'udid': deviceId,
      'phonetype': model,
      'date': date,
      'version': version,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}
