import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:hugeicons/hugeicons.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            const Color.fromARGB(255, 237, 237, 237), // Solid background color
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, -2), // Shadow upwards
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
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
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
          backgroundColor: Colors.transparent, // Container color used instead
          height: 75,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: selectedIndex,
          onDestinationSelected: onTap,
          destinations: [
            NavigationDestination(
              icon: Icon(
                HugeIcons.strokeRoundedHome11,
                size: 26,
                color: selectedIndex == 0
                    ? const Color.fromARGB(255, 81, 81, 81)
                    : Colors.grey,
              ),
              label: 'Home', // Provide a plain string here
            ),
            NavigationDestination(
              icon: Icon(
                HugeIcons.strokeRoundedShoppingCart02,
                size: 26,
                color: selectedIndex == 1
                    ? const Color.fromARGB(255, 81, 81, 81)
                    : Colors.grey,
              ),
              label: 'Cart', // Provide a plain string here
            ),
            NavigationDestination(
              icon: Icon(
                HugeIcons.strokeRoundedUser,
                size: 26,
                color: selectedIndex == 2
                    ? const Color.fromARGB(255, 81, 81, 81)
                    : Colors.grey,
              ),
              label: 'Profile', // Provide a plain string here
            ),
          ],
        ),
      ),
    );
  }
}
