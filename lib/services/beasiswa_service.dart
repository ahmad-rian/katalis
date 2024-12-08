import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/beasiswa_model.dart';

class BeasiswaService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final storage = GetStorage();

  // Fungsi untuk mengambil header yang diperlukan
  Future<Map<String, String>> _getHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  // Fungsi untuk mengambil semua beasiswa
  Future<List<BeasiswaModel>> getAllBeasiswa() async {
    try {
      final headers = await _getHeaders();
      print('Requesting beasiswa with headers: $headers');

      final response = await http
          .get(
            Uri.parse('$baseUrl/beasiswa'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => BeasiswaModel.fromJson(json)).toList();
        }
        throw Exception('Invalid response format');
      }
      throw Exception('Failed to load beasiswa');
    } catch (e) {
      print('Error fetching beasiswa: $e');
      rethrow;
    }
  }

  // Fungsi untuk mencari beasiswa berdasarkan query
  Future<List<BeasiswaModel>> searchBeasiswa(String query) async {
    try {
      final headers = await _getHeaders();
      print('Searching beasiswa with query: $query');

      final response = await http
          .get(
            Uri.parse('$baseUrl/beasiswa/search?query=$query'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => BeasiswaModel.fromJson(json)).toList();
        }
        throw Exception('Invalid search response format');
      }
      throw Exception('Search failed');
    } catch (e) {
      print('Error searching beasiswa: $e');
      rethrow;
    }
  }
}
