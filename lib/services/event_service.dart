import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/event_model.dart';

class EventService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final storage = GetStorage();

  // Fungsi untuk mengambil header yang diperlukan
  Future<Map<String, String>> _getHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  // Fungsi untuk mengambil semua event
  Future<List<EventModel>> getAllEvents() async {
    try {
      final headers = await _getHeaders();
      print('Requesting events with headers: $headers');

      final response = await http
          .get(
            Uri.parse('$baseUrl/events'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => EventModel.fromJson(json)).toList();
        }
        throw Exception('Invalid response format');
      }
      throw Exception('Failed to load events');
    } catch (e) {
      print('Error fetching events: $e');
      rethrow;
    }
  }

  // Fungsi untuk mencari event berdasarkan query
  Future<List<EventModel>> searchEvents(String query) async {
    try {
      final headers = await _getHeaders();
      print('Searching events with query: $query');

      final response = await http
          .get(
            Uri.parse('$baseUrl/events/search?query=$query'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => EventModel.fromJson(json)).toList();
        }
        throw Exception('Invalid search response format');
      }
      throw Exception('Search failed');
    } catch (e) {
      print('Error searching events: $e');
      rethrow;
    }
  }
}
