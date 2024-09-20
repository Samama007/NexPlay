import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nexplay/authentication/login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              tertiaryColor,
              backgroundColor,
              foregroundColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: foregroundColor,
                  ),
                ),
                const Spacer(),
                Hero(
                  tag: 'forgot password',
                  child: Center(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: foregroundColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: 350,
                height: 150,
                child: Text(
                  'Please enter the email address you would like your password reset information sent to.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 320,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    style: TextStyle(color: foregroundColor, fontSize: 15),
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.envelope,
                          color: foregroundColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: foregroundColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          color: foregroundColor,
                        ),
                        errorStyle: TextStyle(color: foregroundColor)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: Icon(
                            Icons.error_outline_outlined,
                            color: foregroundColor,
                            size: 30,
                          ),
                          backgroundColor: foregroundColor,
                          contentTextStyle: TextStyle(color: backgroundColor, fontSize: 18, fontWeight: FontWeight.w200),
                          content: Text(
                            'New password sent to ${_emailController.text}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: backgroundColor,
                            ),
                          ),
                        );
                      },
                    );
                    Future.delayed(const Duration(seconds: 3), () {
                      Get.to(() => const LoginPage());
                    });
                  }
                },
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: foregroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 25, color: backgroundColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
