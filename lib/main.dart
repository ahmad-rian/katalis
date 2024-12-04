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
<<<<<<< HEAD
      initialRoute:
          '/welcome', // Ganti dengan '/onboarding' jika onboarding ingin ditampilkan dulu
      routes: {
        '/home': (context) => HomeScreen(), // Beranda setelah login
        '/login': (context) => LoginScreen(),
        '/onboarding': (context) => OnboardingScreen(), // Halaman onboarding
        '/welcome': (context) =>
            WelcomeScreen(), // Halaman splash screen atau welcome screen
      },
=======
      initialRoute: '/welcome',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
      ],
>>>>>>> 2410863047c4016b1b9664c59dd8387b8f75bf16
    );
  }
}
