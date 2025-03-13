import 'dart:convert';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_model.dart';
import 'package:http/http.dart' as http;

abstract class GoogleMapsRepo {
  static Future<List<ParkingModel>> searchNearbyParking(
      num latitude, num longitude) async {
    print("function called📌📌📌📌");

    const String apiKey = 'AIzaSyB1CdjnS4Dh7ebqr0ViN3jNeo3QSXQU1P4';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1000&type=parking&key=$apiKey';

    print("function called📌📌📌📌 1");
    try {
      final response = await http.get(Uri.parse(url));

      print("function called📌📌📌📌 2");

      if (response.statusCode == 200) {
        print("function called📌📌📌📌 3");
        final data = json.decode(response.body);
        print("function called📌📌📌📌 4");

        print(data['status']);
        print(data);
        print(data['results']);

        final result = (data['results'] as List)
            .map((json) => ParkingModel.fromJson(json))
            .toList();

        print("function called📌📌📌📌 5");
        return result;
      } else {
        print(response.body);
        print("📌📌📌📌");
        print("function called📌📌📌📌 6");
      }
      print("function called📌📌📌📌 7");
    } catch (e) {
      print("function called📌📌📌📌 8");
      print(e);
      print("📌📌📌📌");
      print("function called📌📌📌📌 9");
    }

    print("function called📌📌📌📌 10");
    return [];
  }

  /// 🔹 Search parking by area name
  static Future<List<ParkingModel>> searchParkingByAreaName(
      String areaName) async {
    const String apiKey = 'AIzaSyB1CdjnS4Dh7ebqr0ViN3jNeo3QSXQU1P4';

    final coordinates = await getCoordinates(areaName);
    if (coordinates == null) {
      print("Failed to get coordinates for $areaName");
      return [];
    }

    return await searchNearbyParking(coordinates["lat"]!, coordinates["lng"]!);
  }

  /// 🔹 Convert area name to latitude & longitude
  static Future<Map<String, double>?> getCoordinates(String areaName) async {
    const String apiKey = 'AIzaSyA3k9DlX0tb_dFhU006ahLLS2MnQ-TvvXQ';

    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$areaName&key=$apiKey&';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("📌📌📌📌1 Get coordinates 200");
        final data = json.decode(response.body);
        print("📌📌📌📌2 Get coordinates ${response.body}");
        if (data["results"].isNotEmpty) {
          final location = data["results"][0]["geometry"]["location"];
          print("📌📌📌📌3 Get coordinates ${location}");
          return {"lat": location["lat"], "lng": location["lng"]};
        }
      }
    } catch (e) {
      print("📌📌📌📌4 Get coordinates error");
      print("Error getting coordinates: $e");
    }
    return null;
  }
}
