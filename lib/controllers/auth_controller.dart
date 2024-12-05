// ignore_for_file: use_build_context_synchronously

import 'package:baby_shop_hub/components/etc.dart';
import 'package:baby_shop_hub/screens/homepage.dart';
import 'package:baby_shop_hub/screens/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      successToast('Welcome Back ${user?.displayName}!');

      Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Homepage()));
        },
      );
    } on FirebaseAuthException catch (e) {
      errorToast(getCustomErrorMessage(e.code));
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String address, // New address parameter
    required BuildContext context,
  }) async {
    try {
      // Create the user without logging them in
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update display name in Firebase Authentication
      await userCredential.user?.updateDisplayName(name);

      // Store user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'userId': userCredential.user?.uid, // Store the userId (UID) here
        'name': name,
        'role': 'User',
        'email': email,
        'address': address, // Save address in Firestore
      });

      // Optionally: Store other user data as needed, e.g. password in Firebase Authentication for auth
      // Note: Do not store the password in Firestore for security reasons

      // Immediately sign out the user after signing up
      await _auth.signOut();

      successToast('Account created successfully, please login!');

      // Navigate to login screen after success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      errorToast(getCustomErrorMessage(e.code));
    }
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }
}
