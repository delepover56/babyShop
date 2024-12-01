import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int selectedIndex = 0; // Add this line to manage the selected index

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cart',
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
