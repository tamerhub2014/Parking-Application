import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Map<String, String>> getCityAndCountry(Position position) async {
  try {
    // Reverse geocoding to get address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return {
        "city": place.locality ?? "Unknown",
        "country": place.country ?? "Unknown",
        "longitude": position.longitude.toString(),
        "latitude": position.latitude.toString(),
      };
    } else {
      throw Exception("No address found for the given coordinates.");
    }
  } catch (e) {
    throw Exception("Error getting city and country: $e");
  }
}
