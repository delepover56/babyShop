// ignore_for_file: avoid_print

import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:baby_shop_hub/screens/edit_profile.dart';
import 'package:baby_shop_hub/screens/loginpage.dart';
import 'package:baby_shop_hub/screens/payment.dart';
import 'package:baby_shop_hub/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:baby_shop_hub/controllers/auth_controller.dart';
import 'package:hugeicons/hugeicons.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _capitalizeFirstLetter(String name) {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  User? currentUser;
  @override
  void initState() {
    super.initState();
    _currentUserStatus();
  }

  void _currentUserStatus() {
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });
  }
  // User login status

  @override
  Widget build(BuildContext context) {
    // Responsive design variables
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Scale values
    double avatarSize = screenWidth * 0.2;
    double buttonWidth = screenWidth * 0.4;
    double buttonHeight = screenHeight * 0.05;
    double paddingHorizontal = screenWidth * 0.05;
    double spacingVertical = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentUser != null
              ? 'Hello, ${_capitalizeFirstLetter(currentUser?.displayName ?? "User")}'
              : 'Profile',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.15,
              child: Row(
                children: [
                  // User Avatar
                  ClipOval(
                    child: Image.asset(
                      currentUser != null
                          ? 'assets/Images/Default_User_Pfp.jpg'
                          : 'assets/Images/Default_Gray_User_Pfp.jpg',
                      width: avatarSize,
                      height: avatarSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04), // Space
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (currentUser != null) ...[
                          Text(
                            _capitalizeFirstLetter(
                                currentUser?.displayName ?? 'Guest User'),
                            style: GoogleFonts.montserrat(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spacingVertical * 0.5),
                          Text(
                            _capitalizeFirstLetter(
                                currentUser?.email ?? 'No email available'),
                            style: GoogleFonts.roboto(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ] else ...[
                          _buildButton(
                            label: 'Log In',
                            width: buttonWidth,
                            height: buttonHeight,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 202, 133),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: spacingVertical),
                          _buildButton(
                            label: 'Sign Up',
                            width: buttonWidth,
                            height: buttonHeight,
                            backgroundColor: Colors.transparent,
                            textColor: const Color.fromARGB(255, 255, 202, 133),
                            borderColor:
                                const Color.fromARGB(255, 255, 202, 133),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Settings action
                    },
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSettings03,
                      size: screenWidth * 0.06,
                      color: Colors.black, // Add the required color argument
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacingVertical * 2),
            if (currentUser != null) ...[
              // Option Containers
              _buildOptionContainer(
                icon: HugeIcons.strokeRoundedUserSharing,
                label: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfile(),
                    ),
                  );
                },
              ),
              SizedBox(height: spacingVertical),

              SizedBox(height: spacingVertical),
              _buildOptionContainer(
                icon: HugeIcons.strokeRoundedCreditCardPos,
                label: 'Payment Method',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Payment()),
                  );
                },
              ),
              SizedBox(height: spacingVertical * 2),
              _buildSignOutButton(screenWidth),
            ] else ...[
              // Not logged in message
              Expanded(
                child: Center(
                  child: Text(
                    'You haven\'t logged in yet',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  // Reusable button widget
  Widget _buildButton({
    required String label,
    required double width,
    required double height,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: borderColor != null
              ? BorderSide(color: borderColor, width: 2)
              : null,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: height * 0.35,
          ),
        ),
      ),
    );
  }

  // Reusable option container widget
  Widget _buildOptionContainer({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sign out button
  Widget _buildSignOutButton(double screenWidth) {
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          // Calling the signOut method
          await AuthController().logout(context); // Pass the context here
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.orange,
          side: const BorderSide(color: Colors.orange, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(HugeIcons.strokeRoundedLogout03,
                size: 20, color: Colors.orange),
            const SizedBox(width: 8),
            Text(
              'Sign Out',
              style: GoogleFonts.montserrat(fontSize: screenWidth * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}
