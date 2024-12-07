import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  static final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<Map<String, String>> getHeaders() async {
    String? token = await storage.read(key: 'token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
