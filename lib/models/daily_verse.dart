// A simple data model to hold the verse information.
class DailyVerse {
  late final String text;
  late final String reference;
  // Constructor for the Verse model.
  DailyVerse({required this.text, required this.reference});

  // // A factory constructor to create a Verse from the API's JSON response.
  // factory Verse.fromJson(Map<String, dynamic> json) {
  //   return Verse(
  //     text: json['text'] as String,
  //     reference: json['reference'] as String,
  //   );
  //}
}
