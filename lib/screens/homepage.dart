import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:baby_shop_hub/controllers/products_controller.dart';
import 'package:baby_shop_hub/controllers/cart_controller.dart'; // Import the CartController
import 'package:baby_shop_hub/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart'; // Add import for login screen

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ProductsController _productsController = ProductsController();
  final CartController _cartController =
      CartController(); // Initialize CartController
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _currentUserStatus();
  }

  void _currentUserStatus() {
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  Future<void> _fetchProducts() async {
    try {
      List<Map<String, dynamic>> products =
          await _productsController.fetchProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  String _capitalizeFirstLetter(String name) {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  void _showProductDetailsModal(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Transparent background for modal
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Color.fromARGB(
                255, 237, 237, 237), // Background color to match theme
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "http://localhost/babyshopadminpanel/${product['image']}",
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Product Name
                Text(
                  product['name'] ?? 'Unknown Product',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),

                // Product Price
                Text(
                  '\$${product['price'] ?? '0'}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 16.0),

                // Product Description
                Text(
                  product['description'] ?? 'No description available.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 24.0),

                // Add to Cart Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 226, 179, 123), // Match theme color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    ),
                    onPressed: () {
                      if (currentUser == null) {
                        // If the user is not logged in, redirect to login
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please login first'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        // Call addToCart without the userId parameter
                        _cartController.addToCart(
                          productId: product['id'],
                          name: product['name'],
                          image: product['image'],
                          price: product['price'],
                          description: product['description'],
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product['name']} added to cart'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pop(
                            context); // Close the modal after adding to cart
                      }
                    },
                    child: Text(
                      'Add to Cart',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Welcome ${_capitalizeFirstLetter(currentUser?.displayName ?? "User")}',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedMenu04,
              color: Colors.black,
              size: 24.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedNotification02,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "What Are You Looking For?",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedFilterMailCircle,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),

                      // Category Row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var category in [
                              'All items',
                              'Baby',
                              'Toddler',
                              'Kids'
                            ])
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 202, 133),
                                    ),
                                    foregroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  child: Text(category),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),

// Products Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.67,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          final String imageUrl =
                              "http://localhost/babyshopadminpanel/${product['image']}";

                          return GestureDetector(
                            onTap: () => _showProductDetailsModal(product),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      imageUrl,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        print('Error loading image: $error');
                                        return Center(
                                          child: Icon(Icons.error,
                                              size: 50, color: Colors.red),
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product['name'] ?? 'Unknown',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '\$ ${product['price'] ?? '0'}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}
