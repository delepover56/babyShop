import 'package:baby_shop_hub/controllers/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // For state management
import 'package:baby_shop_hub/screens/profile.dart'; // Make sure to import the Profile page

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    var controller = Provider.of<EditProfileController>(context, listen: false);
    var userData = await controller.getUserData();

    if (userData != null) {
      _nameController.text = userData['name'] ?? '';
      _emailController.text = userData['email'] ?? '';
      _addressController.text = userData['address'] ?? '';
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String address = _addressController.text.trim();
      String password = _passwordController.text.trim();

      var controller =
          Provider.of<EditProfileController>(context, listen: false);

      // Call controller to update profile
      await controller.updateUserData(
        name: name,
        email: email,
        address: address,
        password: password,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );

      // Navigate to Profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double horizontalMargin = screenWidth * 0.05;
    double verticalMargin = screenHeight * 0.05;
    double fieldSpacing = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: fieldSpacing * 2),
                _buildLabel("Name:", screenWidth),
                _buildTextField(controller: _nameController),
                SizedBox(height: fieldSpacing),
                _buildLabel("E-mail:", screenWidth),
                _buildTextField(controller: _emailController),
                SizedBox(height: fieldSpacing),
                _buildLabel("Password (optional):", screenWidth),
                _buildTextField(
                    controller: _passwordController,
                    obscureText: true,
                    hasIcon: true),
                SizedBox(height: fieldSpacing),
                _buildLabel("Address:", screenWidth),
                _buildTextField(controller: _addressController),
                SizedBox(height: fieldSpacing * 2),
                _buildSaveButton(screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double screenWidth) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: screenWidth * 0.05,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    bool obscureText = false,
    bool hasIcon = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: hasIcon ? Icon(Icons.lock) : null,
      ),
      validator: (value) {
        // Only validate password if it's not empty
        if (controller == _passwordController &&
            value!.isNotEmpty &&
            value.length < 6) {
          return 'Password should be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildSaveButton(double screenWidth) {
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
        onPressed: _saveChanges,
        child: Text(
          'Save Changes',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
