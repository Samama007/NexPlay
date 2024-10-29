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
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  Controllers().initializeControllers();

  // runApp(const NexPlay());
  runApp(
    DevicePreview(
      // White background looks professional in website embedding
      backgroundColor: Colors.white,

      // Enable preview by default for web demo
      enabled: true,

      // Start with Galaxy A50 as it's a common Android device
      defaultDevice: Devices.ios.iPhone13ProMax,

      // Show toolbar to let users test different devices
      isToolbarVisible: true,

      // Keep English only to avoid confusion in demos
      availableLocales: [Locale('en', 'US')],

      // Customize preview controls
      tools: const [
        // Device selection controls
        DeviceSection(
          model: true, // Option to change device model to fit your needs
          orientation: false, // Lock to portrait for consistent demo
          frameVisibility: false, // Hide frame options
          virtualKeyboard: false, // Hide keyboard
        ),
      ],

      // Curated list of devices for comprehensive preview
      devices: [
        // ... Devices.all, // uncomment to see all devices

        // Popular Android Devices
        Devices.android.samsungGalaxyA50, // Mid-range
        Devices.android.samsungGalaxyNote20, // Large screen
        Devices.android.samsungGalaxyS20, // Flagship
        Devices.android.samsungGalaxyNote20Ultra, // Premium
        Devices.android.onePlus8Pro, // Different aspect ratio
        Devices.android.sonyXperia1II, // Tall screen

        // Popular iOS Devices
        Devices.ios.iPhoneSE, // Small screen
        Devices.ios.iPhone12, // Standard size
        Devices.ios.iPhone12Mini, // Compact
        Devices.ios.iPhone12ProMax, // Large
        Devices.ios.iPhone13, // Latest standard
        Devices.ios.iPhone13ProMax, // Latest large
        Devices.ios.iPhone13Mini, // Latest compact
        Devices.ios.iPhoneSE, // Budget option
      ],

      /// Your app's entry point
      builder: (context) => const NexPlay(),
    ),
  );
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
    _appStatus();
    _initialize();
  }

  Future _appStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isfirstTime = pref.getBool('firstTime') ?? true;
    });
  }

  Future<void> _initialize() async {
    await _checkLoginStatus();
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? email = pref.getString('currentUserEmail');

    bool? loginStatus = pref.getBool('loginStatus_$email');
    String? currentUsername = pref.getString('username_$email');

    setState(() {
      isLoggedIn = loginStatus ?? false;
      username = currentUsername ?? 'Max';
    });
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
      home: isfirstTime
          ? const OnboardingPage()
          : isLoggedIn
              ? BottomNavBar(name: username)
              : const LoginPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
