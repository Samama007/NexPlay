import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexplay/authentication/forgot_password_page.dart';
import 'package:nexplay/authentication/signup_page.dart';
import 'package:nexplay/widgets/bottom_nav_bar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String username;
    var mheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: mheight,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Colors.black38,
              Colors.red.shade500.withOpacity(0.8),
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
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login to NexPlay!',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Divider(
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
                              style: TextStyle(color: Colors.white, fontSize: 15),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),
                                  prefixIcon: Icon(Icons.lock, color: Colors.white)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length <= 6) {
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
                                username = _emailController.text.replaceAll(RegExp(r'@.*\..*'), '').toUpperCase().toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar(
                                              name: username,
                                            )));
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
                                  'Login',
                                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
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
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
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
}
