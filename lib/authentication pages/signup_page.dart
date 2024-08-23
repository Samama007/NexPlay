// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
          Colors.black38,
          Colors.red.shade500.withOpacity(0.8)
        ])),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 250,
            ),
            Container(
              width: 600,
              height: 570,
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create a new account!',
                    style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "It's quick and easy.",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 450,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 23,
                            ),
                            TextFormField(
                              controller: _namecontroller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
                                  prefixIcon: Icon(Icons.person, color: Colors.white)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                if (value.length < 3) {
                                  return 'Name must be at least 3 characters';
                                }

                                return null;
                              },
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            TextFormField(
                              controller: _emailcontroller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 6, top: 6),
                                    child: FaIcon(FontAwesomeIcons.envelope, color: Colors.white),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                if (!value.contains('@') || !value.contains('.')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            TextFormField(
                              controller: _passwordcontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
                                  prefixIcon: Icon(Icons.lock, color: Colors.white)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                width: 170,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Already have an account?',
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
