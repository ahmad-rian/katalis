import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'views/home_screen.dart';
import 'views/login/login_screen.dart';
import 'views/welcome_screen.dart';
import 'views/onboarding_screen.dart';

import 'package:katalis/views/home_screen.dart';
import 'package:katalis/views/login/login_screen.dart';
import 'package:katalis/views/welcome_screen.dart'; // Import SplashScreen
import 'package:katalis/views/onboarding_screen.dart'; // Import OnboardingScreen

void main() {
  // Pastikan binding framework Flutter sudah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Memasukkan AuthController ke dalam dependency GetX
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalis App',
<<<<<<< HEAD

      // Tema aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Warna dasar latar belakang
      ),

      // Rute awal aplikasi
      initialRoute: '/welcome',

      // Definisi rute GetX
=======
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute:
          '/welcome', // Ganti dengan '/onboarding' jika onboarding ingin ditampilkan dulu
      routes: {
        '/home': (context) => HomeScreen(), // Beranda setelah login
        '/login': (context) => LoginScreen(),
        '/onboarding': (context) => OnboardingScreen(), // Halaman onboarding
        '/welcome': (context) =>
            WelcomeScreen(), // Halaman splash screen atau welcome screen
      },
>>>>>>> 621571ff22df7e2ba87a3fca7f5a80b3d9a55b5e
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          transition: Transition.fadeIn, // Efek transisi antara halaman
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
