// ignore: file_names
import 'package:flutter/material.dart';

class Purchased extends StatefulWidget {
  const Purchased({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PurchasedState createState() => _PurchasedState();
}

class _PurchasedState extends State<Purchased> {
  @override
  void initState() {
    super.initState();
    // Wait for 5 seconds and then pop to the previous screen
    Future.delayed(const Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          const Text(
            'THANK YOU!',
            style: TextStyle(
              decoration: TextDecoration.none,
              letterSpacing: 3,
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const Text(
            'An email receipt has been sent to you.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
