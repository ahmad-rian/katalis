import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/member_model.dart';

class MemberService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final storage = GetStorage();

  Future<Map<String, String>> _getHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<List<Member>> getAllMembers() async {
    try {
      final headers = await _getHeaders();
      print('Requesting members with headers: $headers');

      final response = await http
          .get(
            Uri.parse('$baseUrl/members'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => Member.fromJson(json)).toList();
        }
        throw Exception('Invalid response format');
      }
      throw Exception('Failed to load members');
    } catch (e) {
      print('Error fetching members: $e');
      rethrow;
    }
  }

  Future<List<Member>> searchMembers(String query) async {
    try {
      final headers = await _getHeaders();

      final response = await http
          .get(
            Uri.parse('$baseUrl/members/search?query=$query'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => Member.fromJson(json)).toList();
        }
        throw Exception('Invalid search response format');
      }
      throw Exception('Search failed');
    } catch (e) {
      print('Error searching members: $e');
      rethrow;
    }
  }
}
