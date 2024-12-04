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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/welcome',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: '/welcome',
          page: () => WelcomeScreen(),
          transition: Transition.downToUp,
        ),
      ],
    );
  }
}
