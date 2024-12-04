import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  final storage = FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      clientId:
          '838898865124-ifr1pssrag31a6tfu0sest5lh2polm6v.apps.googleusercontent.com',
      serverClientId:
          '838898865124-ifr1pssrag31a6tfu0sest5lh2polm6v.apps.googleusercontent.com');

  static const baseUrl = 'http://127.0.0.1:8000/api';

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'status': false, 'message': 'Sign in cancelled'};
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final response = await http.post(Uri.parse('$baseUrl/auth/google'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'token': googleAuth.idToken}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['user']);
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'user', value: jsonEncode(data['user']));
        return {'status': true, 'user': user};
      }

      return {
        'status': false,
        'message': 'Authentication failed: ${response.body}'
      };
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await storage.deleteAll();
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }
}
