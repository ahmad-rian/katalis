import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katalis/views/nim/nimfinder_screen.dart';
import 'controllers/auth_controller.dart';
import 'controllers/member_controller.dart';
import 'views/home_screen.dart';
import 'views/login/login_screen.dart';
import 'views/welcome_screen.dart';
import 'views/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthController(), permanent: true);
  Get.put(MemberController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KATALIS',
      theme: ThemeData(
        primaryColor: const Color(0xFF1976D2),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
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
        GetPage(
          name: '/nim-finder',
          page: () => const NimFinderScreen(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
