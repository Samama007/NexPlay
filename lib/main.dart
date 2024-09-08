import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'authentication/firebase module/firebase_options.dart';
import 'dart:ui';
// import 'package:nexplay/authentication/login_page.dart';
import 'package:nexplay/widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const NexPlay());
}

class NexPlay extends StatefulWidget {
  const NexPlay({super.key});

  @override
  State<NexPlay> createState() => _NexPlayState();
}

class _NexPlayState extends State<NexPlay> {
  @override
  void initState() {
    splashInitialization();
    super.initState();
  }

  void splashInitialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch
        },
      ),
      home: BottomNavBar(name: 'username'),
      // home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
    );
  }
}
