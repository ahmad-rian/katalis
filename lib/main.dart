import 'package:flutter/material.dart';
import 'package:katalis/views/home_screen.dart';
import 'package:katalis/views/login/login_screen.dart';
import 'package:katalis/views/welcome_screen.dart'; // Import SplashScreen
import 'package:katalis/views/onboarding_screen.dart'; // Import OnboardingScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalis App',
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
    );
  }
}
