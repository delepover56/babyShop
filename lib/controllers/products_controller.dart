import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController {
  List<Map<String, dynamic>> _allProducts = [];

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

      // Cache the products for search functionality
      _allProducts = products;

      print("Fetched Products: $products");
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  List<Map<String, dynamic>> searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    return _allProducts
        .where((product) =>
            (product['name'] ?? '').toLowerCase().contains(lowerQuery))
        .toList();
  }
}
