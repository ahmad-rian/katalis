import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'views/home_screen.dart';
import 'views/login/login_screen.dart';
import 'views/welcome_screen.dart';
import 'views/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalis App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/welcome',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
      ],
    );
  }
}
