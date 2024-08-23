import 'package:flutter/material.dart';
// import 'package:games_database/authentication%20pages/forgot_password_page.dart';
// import 'package:games_database/authentication%20pages/login_page.dart';
// import 'package:games_database/authentication%20pages/signup_page.dart';
import 'package:games_database/pages/home_page.dart';

void main() {
  runApp(const NexPlay());
}

class NexPlay extends StatefulWidget {
  const NexPlay({super.key});

  @override
  State<NexPlay> createState() => NexPlayState();
}

class NexPlayState extends State<NexPlay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
    );
  }
}
