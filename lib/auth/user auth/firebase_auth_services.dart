// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/views/widgets/toast.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailandPasword(String email, String password,BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        toast('Email already in use, try again with another email or Login',context);
      } else {
        toast("An error occured: ${e.message.toString()}",context);
      }
      return null;
    }
  }

  Future<User?> signInWithEmailandPasword(String email, String password,BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        toast('Invalid Email or Password',context);
      } else {
        toast("An error occured: ${e.message.toString()}",context);
      }
    }
    return null;
  }
}
