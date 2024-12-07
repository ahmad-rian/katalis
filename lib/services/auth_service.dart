import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService extends GetxService {
  final storage = FlutterSecureStorage();
  late final GoogleSignIn _googleSignIn;

  AuthService() {
    // Hanya menggunakan clientId untuk web
    _googleSignIn = GoogleSignIn(
      clientId:
          '838898865124-ifr1pssrag31a6tfu0sest5lh2polm6v.apps.googleusercontent.com',
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
  }

  static const baseUrl = 'http://127.0.0.1:8000/api';

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      print('Starting Google Sign In process...');

      // Reset state jika ada
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return {'status': false, 'message': 'Login dibatalkan'};
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      print('Successfully signed in with Google...');
      print('Email: ${googleUser.email}');

      final response = await http.post(Uri.parse('$baseUrl/auth/google'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'token': idToken,
            'access_token': accessToken,
            'email': googleUser.email,
            'name': googleUser.displayName,
            'photo': googleUser.photoUrl,
          }));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['user']);
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'user', value: jsonEncode(data['user']));
        return {'status': true, 'user': user};
      }

      return {
        'status': false,
        'message': 'Autentikasi gagal: ${response.body}'
      };
    } catch (e) {
      print('Error in signInWithGoogle: $e');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await storage.deleteAll();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }
}
