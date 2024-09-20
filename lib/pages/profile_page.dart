import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/authentication/login_page.dart';
import 'package:nexplay/util/theme.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(foregroundColor),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: backgroundColor,
                      elevation: 20,
                      title: Center(child: Text('Signing Out...', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold))),
                      titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    );
                  },
                );
                _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 20,
                  color: backgroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(foregroundColor),
              ),
              onPressed: () {
                Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
              },
              child: Text(
                'Change Theme',
                style: TextStyle(
                  fontSize: 20,
                  color: backgroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
