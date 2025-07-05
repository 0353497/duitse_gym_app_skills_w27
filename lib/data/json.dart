import 'dart:convert';
import 'package:duitse_gym_app/models/studio.dart';
import 'package:flutter/services.dart';

class DataLoader {
  static Future<List<Studio>> getStudios() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/Data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      final List<dynamic> studiosJson = jsonData['studios'];
      
      return studiosJson.map((studioJson) => Studio.fromJson(studioJson)).toList();
    } catch (e) {
      return [];
    }
  }
}