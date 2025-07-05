import 'package:duitse_gym_app/models/opening_hours.dart';

class Studio {
  final String name;
  final Map<String, OpeningHours?> openingHours;
  final String? news;

  Studio({required this.name, required this.openingHours, this.news});

  factory Studio.fromJson(Map<String, dynamic> json) {
    Map<String, OpeningHours?> openingHoursMap = {};
    
    var hours = json['opening_hours'] as Map<String, dynamic>;
    hours.forEach((key, value) {
      if (value != null) {
        openingHoursMap[key] = OpeningHours.fromJson(value);
      } else {
        openingHoursMap[key] = null;
      }
    });

    return Studio(
      name: json['name'],
      openingHours: openingHoursMap,
      news: json['news'],
    );
  }
}