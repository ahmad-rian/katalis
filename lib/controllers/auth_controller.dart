import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

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
        Get.snackbar('Error', result['message']);
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
