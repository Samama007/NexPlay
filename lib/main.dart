import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nexplay/util/theme.dart';
import 'package:nexplay/views/pages/authentication/login_page.dart';
import 'package:nexplay/views/pages/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/firebase module/firebase_options.dart';
import 'controller/main_controller.dart';
import 'package:nexplay/views/widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  Controllers().initializeControllers();

  runApp(const NexPlay());
}

class NexPlay extends StatefulWidget {
  const NexPlay({super.key});

  @override
  State<NexPlay> createState() => _NexPlayState();
}

class _NexPlayState extends State<NexPlay> {
  bool isLoggedIn = false;
  String username = '';
  bool isfirstTime = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _checkLoginStatus();
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Retrieve current user email
    String? email = pref.getString('currentUserEmail');

    // Retrieve login status and username based on the current email
    if (email != null) {
      bool? loginStatus = pref.getBool('loginStatus_$email'); // Specific login status for the current user
      String? currentUsername = pref.getString('username_$email');

      setState(() {
        isLoggedIn = loginStatus ?? false;
        username = currentUsername ?? 'Max';
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch
        },
      ),
      home: isLoggedIn ? BottomNavBar(name: username) : const LoginPage(),
      // home: isfirstTime
      //     ? OnboardingPage()
      //     : isLoggedIn
      //         ? BottomNavBar(name: username)
      //         : const LoginPage(),
      // home: OnboardingPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
