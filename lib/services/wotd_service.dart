import 'dart:convert';
import 'package:flutter_relearn_provider/models/daily_verse.dart';
import 'package:http/http.dart' as http;

class WordOfTheDayService {
  // The API endpoint for the daily verse
  static const String _apiUrl =
      "https://beta.ourmanna.com/api/v1/get?format=json&order=daily";

  static Future<DailyVerse?> fetchDailyVerse() async {
    try {
      final url = Uri.parse(_apiUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // The API returns an object that contains 'verse' which in turn contains 'details'
        if (data != null && data['verse'] != null && data['verse']['details'] != null) {
          // Extract the verse text
          final verseText = data['verse']['details']['text'] as String?;
          // Extract the reference (e.g., "John 3:16")
          final reference = data['verse']['details']['reference'] as String?;

          if (verseText != null && reference != null) {
            // Combine the text and reference for a complete string
            // return '"$verseText" - $reference';

            return DailyVerse(text: verseText, reference: reference);
          }
        }
        print("WordOfTheDayService: Invalid data format received from API.");
        return null; // Return null if the data structure is not as expected
      } else {
        // Handle non-200 responses
        print(
            "WordOfTheDayService: Failed to load verse. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle potential errors like no internet connection
      print("WordOfTheDayService: An error occurred: $e");
      return null;
    }
  }
}
