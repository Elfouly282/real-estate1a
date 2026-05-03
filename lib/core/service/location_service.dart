import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

class UserLocation {
  final String name;
  final double latitude;
  final double longitude;

  const UserLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

@injectable
class LocationService {
  Future<Either<Failure, UserLocation>> getCurrentLocationName() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return left( LocationFailure('Location services are disabled.'));
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return left( LocationFailure('Location permission denied.'));
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return left( LocationFailure('Location permission permanently denied.'));
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String locationName = 'Unknown Location';
      if (placemarks.isNotEmpty) {
        final place   = placemarks.first;
        final city    = place.locality ?? place.subAdministrativeArea ?? '';
        final country = place.country ?? '';
        locationName  = '$city, $country'.trim().replaceAll(RegExp(r'^,|,$'), '');
      }

      return right(UserLocation(
        name:      locationName,
        latitude:  position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }
}