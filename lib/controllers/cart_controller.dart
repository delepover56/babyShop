import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String productId,
    required String name,
    required String image,
    required String price,
    required String description,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not logged in');
        return;
      }

      // Debug: Test Firestore Write
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .add({'testKey': 'testValue'});
        print('Test write successful');
      } catch (e) {
        print('Error writing to Firestore: $e');
        return; // Skip further execution if test write fails
      }

      CollectionReference cart =
          _firestore.collection('users').doc(user.uid).collection('cart');

      QuerySnapshot existingCartItem =
          await cart.where('productId', isEqualTo: productId).get();

      if (existingCartItem.docs.isNotEmpty) {
        String cartId = existingCartItem.docs.first.id;
        print('Cart item exists. Updating quantity for: $cartId');
        await cart.doc(cartId).update({
          'quantity': FieldValue.increment(1),
        });
      } else {
        print('Cart item does not exist. Adding new item: $productId');
        await cart.add({
          'productId': productId,
          'name': name,
          'image': image,
          'price': price,
          'description': description,
          'quantity': 1,
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
}
