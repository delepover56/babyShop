import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentsController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add or update payment details
  Future<void> savePaymentDetails({
    required String cardNumber,
    required String cardHolderName,
    required String expiryDate,
    required String cvv,
    required String address,
  }) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.uid;

        await _firestore.collection('payments').doc(userId).set({
          'userId': userId,
          'cardNumber': cardNumber,
          'cardHolderName': cardHolderName,
          'expiryDate': expiryDate,
          'cvv': cvv,
          'address': address,
        });

        print("Payment details saved for user: $userId");
      }
    } catch (e) {
      print("Error saving payment details: $e");
    }
  }

  // Fetch payment details
  Future<Map<String, dynamic>?> getPaymentDetails() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('payments').doc(currentUser.uid).get();
        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print("Error fetching payment details: $e");
    }
    return null;
  }

  // Delete payment details
  Future<void> deletePaymentDetails() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('payments').doc(currentUser.uid).delete();
        print("Payment details deleted for user: ${currentUser.uid}");
      }
    } catch (e) {
      print("Error deleting payment details: $e");
    }
  }
}
