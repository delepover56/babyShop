import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:baby_shop_hub/screens/homepage.dart';
import 'package:baby_shop_hub/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 0; // Add this line to manage the selected index

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Variable to track if the user is logged in
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    // Fetch screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Responsive font size calculation
    double responsiveFontSize = MediaQuery.textScaleFactorOf(context) * 16.0;

    // Calculate dimensions dynamically
    double avatarSize = screenWidth * 0.2; // Avatar size (20% of screen width)
    double buttonWidth =
        screenWidth * 0.4; // Reduced button width (40% of screen width)
    double buttonHeight =
        screenHeight * 0.05; // Reduced button height (5% of screen height)

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hello, User',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // 5% of screen width
          vertical: screenHeight * 0.03, // 3% of screen height
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      isLoggedIn
                          ? 'assets/Images/Default_User_Pfp.jpg'
                          : 'assets/Images/Default_Gray_User_Pfp.jpg',
                      width: avatarSize,
                      height: avatarSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                      width:
                          screenWidth * 0.04), // Space between avatar and text
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isLoggedIn) ...[
                          Text(
                            'Current User',
                            style: GoogleFonts.montserrat(
                              fontSize: responsiveFontSize * 0.8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'dummyemail@google.com',
                            style: GoogleFonts.roboto(
                              fontSize: responsiveFontSize * 0.7,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ] else ...[
                          _buildButton(
                            label: 'Log In',
                            width: buttonWidth,
                            height: buttonHeight,
                            backgroundColor: Color.fromARGB(255, 255, 202, 133),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                            },
                          ),
                          SizedBox(
                              height:
                                  screenHeight * 0.02), // Space between buttons
                          _buildButton(
                            label: 'Sign Up',
                            width: buttonWidth,
                            height: buttonHeight,
                            backgroundColor: Colors.transparent,
                            textColor: Color.fromARGB(255, 255, 202, 133),
                            borderColor: Color.fromARGB(255, 255, 202, 133),
                            onPressed: () {
                              // Action for signup
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
                      color: Colors.black,
                      size: screenWidth * 0.06, // 6% of screen width
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth * 0.09),
            if (isLoggedIn) ...[
// Edit Profile Container
              GestureDetector(
                onTap: () {
                  // Action for "Edit Profile"
                  print("Edit Profile tapped");
                  // Add your navigation or logic here
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Action for the button
                          print("Edit Profile button clicked");
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedUserSharing,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenWidth * 0.02),

// Address Container
              GestureDetector(
                onTap: () {
                  // Action for "Address"
                  print("Address tapped");
                  // Add your navigation or logic here
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Action for the button
                          print("Address button clicked");
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedLocation01,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenWidth * 0.02),

// Payment Method Container
              GestureDetector(
                onTap: () {
                  // Action for "Payment Method"
                  print("Payment Method tapped");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Homepage(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Action for the button
                          print("Payment Method button clicked");
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedCreditCardPos,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenWidth * 0.1),

// Sign Out Container
              GestureDetector(
                onTap: () {
                  // Action for "Sign Out"
                  print("Sign Out tapped");
                  // Add your sign-out logic here
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 2, 24, 2),
                    decoration: BoxDecoration(
                      color: Colors.white, // Transparent background
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.orange, // Orange border color
                        width: 2.0, // Border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Action for the button
                            print("Sign Out button clicked");
                          },
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedLogout03,
                            color: Colors.orange, // Orange foreground color
                            size: 24.0,
                          ),
                        ),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.orange, // Orange text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'You haven\'t logged in yet',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

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
          style: GoogleFonts.jua(
            fontSize: height * 0.35, // Slightly smaller font size
          ),
        ),
      ),
    );
  }
}
