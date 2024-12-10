import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      List<Map<String, dynamic>> products = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String imageUrl = data['imageUrl'] ?? '';
        data['imageUrl'] = imageUrl; // Assign imageUrl to the data
        return data;
      }).toList();

      print("Fetched Products: $products");
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
