// ignore_for_file: avoid_print

import 'package:baby_shop_hub/controllers/payments_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String productId,
    required String name,
    required String image,
    required String price,
    required String description,
    required int quantity, // New quantity parameter
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not logged in');
        return;
      }

      CollectionReference cart =
          _firestore.collection('users').doc(user.uid).collection('cart');

      QuerySnapshot existingCartItem =
          await cart.where('productId', isEqualTo: productId).get();

      if (existingCartItem.docs.isNotEmpty) {
        String cartId = existingCartItem.docs.first.id;
        print('Cart item exists. Updating quantity for: $cartId');
        await cart.doc(cartId).update({
          'quantity':
              FieldValue.increment(quantity), // Increment by selected quantity
        });
      } else {
        print('Cart item does not exist. Adding new item: $productId');
        await cart.add({
          'productId': productId,
          'name': name,
          'image': image,
          'price': price,
          'description': description,
          'quantity': quantity, // Add the selected quantity
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      print('Product added to cart!');
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUserCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return [];
    }

    try {
      CollectionReference cart =
          _firestore.collection('users').doc(user.uid).collection('cart');
      QuerySnapshot querySnapshot = await cart.get();

      return querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  Future<void> cancelOrder(String productId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not logged in');
        return;
      }

      // Reference to the user's cart
      CollectionReference cart =
          _firestore.collection('users').doc(user.uid).collection('cart');

      // Query to find the cart item by productId
      QuerySnapshot existingCartItem =
          await cart.where('productId', isEqualTo: productId).get();

      if (existingCartItem.docs.isNotEmpty) {
        // Get the cart item document ID
        String cartId = existingCartItem.docs.first.id;
        // Get the product name from the cart item
        String productName = existingCartItem.docs.first['name'];

        // Delete the cart item
        await cart.doc(cartId).delete();

        // Print the product name
        print('Order for product: $productName canceled successfully.');
      } else {
        print('Product not found in cart.');
      }
    } catch (e) {
      print('Error canceling order: $e');
    }
  }

  Future<String> createOrder(
      String productId, String productName, String paymentMethod) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return 'User not logged in';
      }

      CollectionReference cart = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart');
      CollectionReference orders =
          FirebaseFirestore.instance.collection('orders');

      QuerySnapshot existingCartItem =
          await cart.where('productId', isEqualTo: productId).get();

      if (existingCartItem.docs.isNotEmpty) {
        // Get the cart item document
        DocumentSnapshot cartItem = existingCartItem.docs.first;
        String cartId = cartItem.id;
        int quantity = cartItem['quantity']; // Retrieve quantity from the cart

        var uid = Uuid();
        var orderId = uid.v1();

        Map<String, dynamic> paymentDetails = {};
        bool isPaymentSuccessful = false;

        if (paymentMethod == 'Pay Now') {
          PaymentsController paymentsController = PaymentsController();
          Map<String, dynamic>? fetchedPaymentDetails =
              await paymentsController.getPaymentDetails();

          if (fetchedPaymentDetails != null) {
            paymentDetails = fetchedPaymentDetails;
            isPaymentSuccessful = true;
          } else {
            return 'Payment failed. No saved payment details found.';
          }
        } else if (paymentMethod == 'Cash on Delivery') {
          isPaymentSuccessful = true;
        }

        if (isPaymentSuccessful) {
          await orders.doc(orderId).set({
            'orderId': orderId,
            'productId': productId,
            'name': productName,
            'quantity': quantity, // Include the quantity
            'status': 'Order being processed',
            'timestamp': FieldValue.serverTimestamp(),
            'userId': user.uid,
            'payment': paymentMethod,
            ...paymentDetails,
          });

          // Update the cart item status
          await cart.doc(cartId).update({'status': 'Order being processed'});

          return 'Order for $productName (Quantity: $quantity) has been created successfully using $paymentMethod.';
        } else {
          return 'Payment failed.';
        }
      } else {
        return 'Product not found in cart.';
      }
    } catch (e) {
      return 'Error creating order: $e';
    }
  }
}
