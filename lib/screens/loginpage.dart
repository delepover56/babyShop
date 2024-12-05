// ignore_for_file: avoid_print

import 'package:baby_shop_hub/controllers/auth_controller.dart';
import 'package:baby_shop_hub/components/etc.dart';
import 'package:baby_shop_hub/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorToast('Please fill out both fields');
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      errorToast('Please enter a valid email address');
      return;
    }

    await _authController.login(
      email: email,
      password: password,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome Back!',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.06, // Responsive font size
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,
          vertical: screenHeight * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.montserrat(
                    fontSize: screenWidth * 0.055, // Responsive font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Proportional spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email Label
                  Text(
                    'E-mail:',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // Proportional spacing
                  // Email Input
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 169, 169, 169),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // Proportional spacing
                  // Password Label
                  Text(
                    'Password:',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // Proportional spacing
                  // Password Input
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 169, 169, 169),
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedSquareLock02,
                          color: Colors.black,
                          size: screenWidth * 0.06, // Scaled icon size
                        ),
                      ),
                    ),
                  ),
                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      print('Forgot Password Clicked');
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.montserrat(
                          fontSize: screenWidth * 0.04,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04), // Proportional spacing
                  // Login Button
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange[300],
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: screenHeight * 0.02,
                        ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _handleLogin,
                      child: Text(
                        'Login',
                        style: GoogleFonts.montserrat(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // Proportional spacing
                  // Sign Up Option
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Create one here',
                            style: GoogleFonts.montserrat(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
