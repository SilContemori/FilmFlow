import 'package:filmflow/global/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(
            message: 'The email address is already in use.',
            colors: Colors.red);
      } else {
        showToast(message: 'An error occurred: ${e.code}', colors: Colors.red);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPAssword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.', colors: Colors.red);
      } else {
        showToast(message: 'An error occurred: ${e.code}', colors: Colors.red);
      }
    }
    return null;
  }
}
