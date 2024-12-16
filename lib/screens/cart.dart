// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:baby_shop_hub/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController _cartController = CartController();
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final items = await _cartController.getUserCart();
      setState(() {
        cartItems = items;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching cart items: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void removeCartItem(String productId) async {
    // Call the cancelOrder method from CartController
    await _cartController.cancelOrder(productId);
    // Refresh the cart items after removal
    fetchCartItems();
  }

  void payForItem(String productId, String productName) async {
    // Show Payment Options Modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isLargeScreen = constraints.maxWidth > 600;
              double fontSize = isLargeScreen ? 18 : 16;
              double buttonPaddingVertical = isLargeScreen ? 20 : 12;
              double buttonPaddingHorizontal = isLargeScreen ? 50 : 30;

              return Container(
                padding: const EdgeInsets.all(20),
                color: Color.fromARGB(255, 237, 237, 237),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Select Payment Method',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: buttonPaddingVertical,
                                  horizontal: buttonPaddingHorizontal),
                              backgroundColor:
                                  Color.fromARGB(255, 226, 179, 123),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              String message =
                                  await _cartController.createOrder(
                                productId,
                                productName,
                                'Cash on Delivery',
                              );
                              Navigator.pop(context); // Close modal
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            },
                            child: Text(
                              'Cash on Delivery',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: buttonPaddingVertical,
                                  horizontal: buttonPaddingHorizontal),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              String message =
                                  await _cartController.createOrder(
                                productId,
                                productName,
                                'Pay Now',
                              );
                              Navigator.pop(context); // Close modal
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            },
                            child: Text(
                              'Pay Now',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? Center(
                  child: Text(
                    'Your cart is empty',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final String imageUrl =
                        "http://localhost/babyshopadminpanel/${item['image']}";
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: item['image'] != null &&
                                          item['image'] != ''
                                      ? NetworkImage(imageUrl)
                                      : const AssetImage(
                                              'assets/images/Bunny.jpg')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
// Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),
                                  Text(
                                    'Price: \$${item['price']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Quantity: ${item['quantity']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  // Show status text if the item has been ordered
                                  if (item['status'] != null) ...[
                                    Text(
                                      item[
                                          'status'], // For example, 'Order being processed'
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                  // Action Buttons below the product details
                                  if (item['status'] == null) ...[
                                    // Show action buttons for unplaced orders (items with no status)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top:
                                              10), // Add space between details and buttons
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, // Align buttons to the start
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.payment,
                                                color: Colors.green),
                                            onPressed: () => payForItem(
                                                item['productId'],
                                                item['name']),
                                          ),
                                          SizedBox(width: 20),
                                          IconButton(
                                            icon: Icon(Icons.cancel,
                                                color: Colors.red),
                                            onPressed: () => removeCartItem(
                                                item['productId']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
