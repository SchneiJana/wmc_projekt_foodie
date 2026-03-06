import 'dart:convert';

import 'package:foodie_app/models/food.dart';
import 'package:http/http.dart' as http;

class DbService {
  final String baseUrl = 'http://10.0.2.2:3000';
  final http.Client _client;

  DbService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Food>> getFoods() async {
    final uri = Uri.parse('$baseUrl/foods');

    try {
      final response = await _client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      _client.close();

      List<dynamic> body = jsonDecode(response.body);

      List<Food> skills = body
          .map((dynamic item) => Food.fromJson(item as Map<String, dynamic>))
          .toList();

      return skills;
    } catch (e) {
      return List<Food>.empty();
    }
  }
}
