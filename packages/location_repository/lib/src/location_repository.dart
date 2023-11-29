import 'package:geolocator/geolocator.dart';
import 'package:location_repository/src/model/current_location.dart';

/// Failure model that implement error
class CurrentLocationFailure implements Exception {
  /// instance of failure model
  CurrentLocationFailure({
    required this.error,
  });

  /// the error name if somethig went wrong
  final String error;
}

/// {@template location_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class LocationRepository {

  /// {@macro location_repository}
  LocationRepository();

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final _geolocatorPlatform = GeolocatorPlatform.instance;
  /// Function to get current location
  Future<CurrentUserLocationEntity> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw CurrentLocationFailure(
        error: _kLocationServicesDisabledMessage,
      );
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      final permission  = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        throw CurrentLocationFailure(
          error: _kPermissionDeniedMessage,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw CurrentLocationFailure(
        error: _kPermissionDeniedForeverMessage,
      );
    }

    late Position? position;

    try {
      position = await _geolocatorPlatform.getLastKnownPosition();
      if (position != null) {
        return CurrentUserLocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      }  else {
        position = await _geolocatorPlatform.getCurrentPosition();
      }
    } catch (_) {
      throw CurrentLocationFailure(
        error: 'Something went wrong getting your location, '
            'please try again later',
      );
    }

    final latitude = position.latitude;
    final longitude = position.longitude;

    if (position == null) {
      throw CurrentLocationFailure(
        error: 'Something went wrong getting your location, '
            'please try again later',
      );
    }

    return CurrentUserLocationEntity(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
