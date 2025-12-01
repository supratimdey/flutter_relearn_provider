import 'dart:convert';

import 'package:flutter_relearn_provider/models/pexel_image_data.dart';
import 'package:http/http.dart' as http;

class PexelsService {
  static const String apiKey =
      "DzCXpJjTzMuPJGEjSnf5WcG5XH4oVzz6oGUUc6yhioDRRiTHVPObTZWZ";

  static const String collectionId = "3mb6tlh";

  static const int totalImages = 31;

  static Future<PexelImageData?> getTodayImage() async {
    final url = Uri.parse(
      "https://api.pexels.com/v1/collections/$collectionId?per_page=$totalImages",
    );

    final response = await http.get(
      url,
      headers: {"Authorization": apiKey},);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["media"] == null) {
        print("No media found in the response.");
        return null;
      }
      final List photos = data["media"] as List<dynamic>;

      if (photos.isEmpty) {
        print("No photos available in the media.");
        return null;
      }

      // Extract the image URL for today's image based on the day of the month
      final today = DateTime.now().day;

      if (today > photos.length){
        print("day of the month is greater .");

        final imageUrl = photos[0]["src"]["large"] as String;
        final avgColor =photos[0]["avg_color"] as String;

        return PexelImageData(imageUrl, avgColor);
      }

      final imageUrl = photos[today - 1]["src"]["large"] as String;
      final avgColor = photos[today - 1]["avg_color"] as String;

      return PexelImageData(imageUrl, avgColor);
       
    }
    print("Failed to load image. Status code: ${response.statusCode} ${response.body}");
    return null;
  }
}
