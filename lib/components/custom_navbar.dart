import 'package:baby_shop_hub/screens/cart.dart';
import 'package:baby_shop_hub/screens/homepage.dart';
import 'package:baby_shop_hub/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  // Index of the currently selected screen
  int selectedIndex = 0;

  // Handles the tapping on a bottom navigation item
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Update the screen based on the selected index
    if (selectedIndex == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Homepage()));
    }
    if (selectedIndex == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Cart()));
    }
    if (selectedIndex == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Profile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 237, 237, 237),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color.fromARGB(255, 226, 179, 123),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 226, 179, 123),
              );
            } else {
              return GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              );
            }
          }),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          height: 75,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: selectedIndex, // Set the selected index
          onDestinationSelected: onTap, // Handle tap to update index
          destinations: [
            NavigationDestination(
              icon: Icon(
                HugeIcons.strokeRoundedHome11,
                size: 20,
                color: selectedIndex == 0
                    ? const Color.fromARGB(255, 81, 81, 81)
                    : Colors.grey,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                HugeIcons.strokeRoundedShoppingCart02,
                size: 20,
                color: selectedIndex == 1
                    ? const Color.fromARGB(255, 81, 81, 81)
                    : Colors.grey,
              ),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(
                HugeIcons.strokeRoundedUser,
                size: 20,
                color: selectedIndex == 2
                    ? const Color.fromARGB(255, 81, 81, 81)
                    : Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
