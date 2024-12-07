import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final AuthService _authService = Get.put(AuthService());
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final result = await _authService.signInWithGoogle();

      if (result['status']) {
        user.value = result['user'];
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Authentication failed',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          maxWidth: Get.width * 0.9,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          borderRadius: 8,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    user.value = null;
    Get.offAllNamed('/login');
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
