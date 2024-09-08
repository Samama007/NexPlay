import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexplay/widgets/toast.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailandPasword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        toast('Email already in use, try again with another email or Login');
      } else {
        toast("An error occured: ${e.message.toString()}");
      }
      return null;
    }
  }

  Future<User?> signInWithEmailandPasword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        toast('Invalid Email or Password');
      } else {
        toast("An error occured: ${e.message.toString()}");
      }
    }
    return null;
  }
}
