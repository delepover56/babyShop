import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const Cart({super.key, required this.selectedIndex, required this.onTap});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cart',
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: widget.selectedIndex, // Access selectedIndex via widget
        onTap: widget.onTap, // Access onTap via widget
      ),
    );
  }
}
