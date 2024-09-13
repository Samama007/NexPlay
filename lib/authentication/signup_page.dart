import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/authentication/login_page.dart';
import 'package:nexplay/authentication/user%20auth/firebase_auth_services.dart';
import 'package:nexplay/widgets/toast.dart';

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
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Create a new account!',
                        style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                      const Text(
                        "It's quick and easy.",
                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      const Divider(
                        color: Colors.white,
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
                                const SizedBox(
                                  height: 13,
                                ),
                                TextFormField(
                                  controller: _namecontroller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Full Name",
                                      hintStyle: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                                      prefixIcon: const Icon(Icons.person, color: Colors.white)),
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
                                const SizedBox(
                                  height: 23,
                                ),
                                TextFormField(
                                  controller: _emailcontroller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Email Address",
                                      hintStyle: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                                      prefixIcon: const Icon(Icons.email_outlined, size: 25, color: Colors.white)),
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
                                const SizedBox(
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
                                      hintStyle: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
                                      prefixIcon: const Icon(Icons.lock, color: Colors.white)),
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
                                      color: Colors.red.shade500,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: isLoading
                                          ? const CircularProgressIndicator()
                                          : const Text(
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
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
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
      Future.delayed(const Duration(seconds: 2));
      toast('User successfully created');
      Get.to(const LoginPage());
    }
  }
}
