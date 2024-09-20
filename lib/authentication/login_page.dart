import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nexplay/authentication/forgot_password_page.dart';
import 'package:nexplay/authentication/signup_page.dart';
import 'package:nexplay/authentication/user%20auth/firebase_auth_services.dart';
import 'package:nexplay/widgets/bottom_nav_bar.dart';
import 'package:nexplay/widgets/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              backgroundColor,
              foregroundColor,
              tertiaryColor,
            ]),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 250,
                width: 400,
              ),
              const SizedBox(height: 10),
              Container(
                width: 350,
                height: 430,
                decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login to NexPlay!',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: foregroundColor),
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(color: foregroundColor, fontSize: 15),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: foregroundColor),
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 15, color: foregroundColor, fontWeight: FontWeight.w300),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: foregroundColor,
                                ),
                                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@') || !value.contains('.')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: foregroundColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: 15, color: foregroundColor, fontWeight: FontWeight.w300),
                                  prefixIcon: Icon(Icons.lock, color: foregroundColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length <= 5) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
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
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 30, color: backgroundColor, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                            },
                            child: Hero(
                              tag: 'forgot password',
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: foregroundColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: backgroundColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                    },
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailandPasword(email, password, context);
    if (!mounted) return;

    if (user != null) {
      String username = _emailController.text.replaceAll(RegExp(r'@.*\..*'), '').toUpperCase().toString();
      toast('Welcome $username', context);
      Get.to(BottomNavBar(name: username));
    }
  }
}
