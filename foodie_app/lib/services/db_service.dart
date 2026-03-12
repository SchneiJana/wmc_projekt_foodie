import 'dart:convert';

import 'package:foodie_app/models/food.dart';
import 'package:http/http.dart' as http;

class DbService {
  final String baseUrl = 'http://10.58.112.160:3000';
  final http.Client _client;

  DbService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Food>> getFoods([String? searchString]) async {
    final uri = (searchString != null && searchString.isNotEmpty)
        ? Uri.parse('$baseUrl/foods/$searchString')
        : Uri.parse('$baseUrl/foods');

    try {
      final response = await _client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.body.isEmpty) return [];

      dynamic body = jsonDecode(response.body);

      if (body is List) {
        return body
            .map((dynamic item) => Food.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (body is Map<String, dynamic>) {
        return [Food.fromJson(body)];
      }

      return [];
    } catch (e) {
      return List<Food>.empty();
    }
  }
}
