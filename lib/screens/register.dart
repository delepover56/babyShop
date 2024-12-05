import 'package:baby_shop_hub/controllers/auth_controller.dart';
import 'package:baby_shop_hub/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController =
      TextEditingController(); // New controller for address

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define base padding and scaling factors
    double basePadding = screenWidth * 0.05;
    double fieldSpacing = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign Up!',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.065, // Responsive font size
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: basePadding),
          child: Form(
            // Wrap the form elements with a Form widget
            key: _formKey, // Attach the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: fieldSpacing),
                _buildLabel("Name:", screenWidth),
                _buildTextField(controller: _nameController),
                SizedBox(height: fieldSpacing),
                _buildLabel("E-mail:", screenWidth),
                _buildTextField(controller: _emailController),
                SizedBox(height: fieldSpacing),
                _buildLabel("Password:", screenWidth),
                _buildTextField(
                    controller: _passwordController,
                    obscureText: true,
                    hasIcon: true),
                SizedBox(height: fieldSpacing),
                _buildLabel("Address:", screenWidth), // Address label
                _buildTextField(
                    controller: _addressController), // Address field
                SizedBox(height: fieldSpacing * 2),
                _buildSignUpButton(screenWidth),
                SizedBox(height: fieldSpacing * 2),
                _buildLoginPrompt(screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text field labels
  Widget _buildLabel(String text, double screenWidth) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: screenWidth * 0.05, // Responsive font size
        color: Colors.black,
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    bool obscureText = false,
    bool hasIcon = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 200, 200, 200),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 169, 169, 169),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 200, 200, 200),
            width: 1.0,
          ),
        ),
        suffixIcon: hasIcon
            ? Icon(
                HugeIcons.strokeRoundedSquareLock02,
                color: Colors.black,
                size: 24.0,
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
    );
  }

  // Helper method to build the Sign-Up button
  Widget _buildSignUpButton(double screenWidth) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.2,
            vertical: screenWidth * 0.04,
          ),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            // Validate form fields
            String name = _nameController.text.trim();
            String email = _emailController.text.trim();
            String password = _passwordController.text.trim();
            String address = _addressController.text.trim(); // Get address

            // Call signup function from AuthController
            await AuthController().signup(
              email: email,
              password: password,
              name: name,
              address: address, // Pass address
              context: context,
            );
          }
        },
        child: Text(
          'Sign Up',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper method to build the Login prompt
  Widget _buildLoginPrompt(double screenWidth) {
    return Column(
      children: [
        Text(
          'Already have an account?',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.045,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login ',
              style: GoogleFonts.montserrat(
                fontSize: screenWidth * 0.045,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                );
              },
              child: Text(
                'here',
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
