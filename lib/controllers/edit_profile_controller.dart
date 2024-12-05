import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Import this for ChangeNotifier

class EditProfileController extends ChangeNotifier {
  // Firebase instances for authentication and Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(currentUser.uid).get();
        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }

  // Update user data in Firebase Authentication and Firestore
  Future<void> updateUserData({
    required String name,
    required String email,
    required String address,
    required String password, // Optional password change
  }) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);
        print("Updated display name to: $name");

        // Update email if it's different
        if (email != currentUser.email) {
          await currentUser.verifyBeforeUpdateEmail(email);
          print("Updated email to: $email");
        }

        // Update Firestore data
        await _firestore.collection('users').doc(currentUser.uid).update({
          'name': name,
          'email': email,
          'address': address,
        });

        print(
            "Firestore updated with name: $name, email: $email, address: $address");

        // If a new password is provided, update it
        if (password.isNotEmpty) {
          await currentUser.updatePassword(password);
          print("Password updated");
        }

        // Notify listeners about the update
        notifyListeners();
      }
    } catch (e) {
      print("Error updating user data: $e");
      // Optionally, you could display a snackbar or error dialog to the user
    }
  }
}
