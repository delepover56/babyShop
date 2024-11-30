import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTap;
  const Profile({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile',
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: widget.selectedIndex, // Access selectedIndex via widget
        onTap: widget.onTap, // Access onTap via widget
      ),
    );
  }
}
