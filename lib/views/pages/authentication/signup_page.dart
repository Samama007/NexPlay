import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/views/pages/authentication/login_page.dart';
import 'package:nexplay/auth/user%20auth/firebase_auth_services.dart';
import 'package:nexplay/views/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

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
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    var mheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: mheight,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
            backgroundColor,
            foregroundColor,
            tertiaryColor,
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
                decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create a new account!',
                        style: TextStyle(fontSize: 28, color: foregroundColor, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "It's quick and easy.",
                        style: TextStyle(fontSize: 15, color: foregroundColor, fontWeight: FontWeight.w300),
                      ),
                      Divider(
                        color: foregroundColor,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 13),
                                TextFormField(
                                  style: TextStyle(color: foregroundColor),
                                  controller: _namecontroller,
                                  cursorColor: foregroundColor,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: foregroundColor)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Full Name",
                                      errorStyle: TextStyle(color: foregroundColor),
                                      hintStyle: TextStyle(fontSize: 15, color: foregroundColor, fontWeight: FontWeight.w300),
                                      prefixIcon: Icon(Icons.person, color: foregroundColor)),
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
                                const SizedBox(height: 23),
                                TextFormField(
                                  style: TextStyle(color: foregroundColor),
                                  controller: _emailcontroller,
                                  cursorColor: foregroundColor,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: foregroundColor)),
                                      hintText: "Email Address",
                                      errorStyle: TextStyle(color: foregroundColor),
                                      hintStyle: TextStyle(fontSize: 15, color: foregroundColor, fontWeight: FontWeight.w300),
                                      prefixIcon: Icon(Icons.email_outlined, size: 25, color: foregroundColor)),
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
                                const SizedBox(height: 23),
                                TextFormField(
                                  style: TextStyle(color: foregroundColor),
                                  controller: _passwordcontroller,
                                  obscureText: true,
                                  cursorColor: foregroundColor,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: foregroundColor)),
                                      hintText: "Password",
                                      errorStyle: TextStyle(color: foregroundColor),
                                      hintStyle: TextStyle(fontSize: 15, color: foregroundColor, fontWeight: FontWeight.w100),
                                      prefixIcon: Icon(Icons.lock, color: foregroundColor)),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _signUp();
                                    }
                                  },
                                  child: Container(
                                    width: 170,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: foregroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: isLoading
                                          ? CircularProgressIndicator(color: backgroundColor)
                                          : Text(
                                              'Sign Up',
                                              style: TextStyle(fontSize: 25, color: backgroundColor, fontWeight: FontWeight.w600),
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
              const SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 22, color: backgroundColor, fontWeight: FontWeight.w600),
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
    String username = _namecontroller.text;

    User? user = await _auth.signUpWithEmailandPasword(email, password, context);
    if (!mounted) return;

    if (user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();

      // Store user-specific data using email as the key
      await pref.setString('username_$email', username);

      // Store login status specifically for this user
      await pref.setBool('loginStatus_$email', true);

      // Store current user email globally
      await pref.setString('currentUserEmail', email);

      toast('Welcome to NexPlay, $username', context);
      Get.to(() => const LoginPage());
    }
  }
}
