// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/authentication/login_page.dart';
import 'package:nexplay/authentication/user%20auth/firebase_auth_services.dart';
import 'package:nexplay/widgets/toast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namecontroller = TextEditingController();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: mheight,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Colors.black38,
            Colors.red.shade500.withOpacity(0.8)
          ])),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 250,
                height: 230,
              ),
              Container(
                width: 350,
                height: 450,
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create a new account!',
                        style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "It's quick and easy.",
                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 13,
                                ),
                                TextFormField(
                                  controller: _namecontroller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Full Name",
                                      hintStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
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
                                      hintStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                                      prefixIcon: Icon(Icons.email_outlined, size: 25, color: Colors.white)),
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
                                      _signUp();
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
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String email = _emailcontroller.text;
    String password = _passwordcontroller.text;

    User? user = await _auth.signUpWithEmailandPasword(email, password);

    if (user != null) {
      toast('User successfully created');
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
