import 'package:http/http.dart' as http;
import 'package:katalis/models/member_model.dart';
import 'dart:convert';

class MemberService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Member>> getAllMembers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/members'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Member.fromJson(json)).toList();
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Member>> searchMembers(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/members?nim=$query'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Member.fromJson(json)).toList();
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
