import 'package:baby_shop_hub/controllers/payments_controller.dart';
import 'package:baby_shop_hub/controllers/edit_profile_controller.dart';
import 'package:baby_shop_hub/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');
    StringBuffer formattedText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 4 || i == 8 || i == 12) {
        formattedText.write(' ');
      }
      formattedText.write(text[i]);
    }
    return newValue.copyWith(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class AddPayment extends StatefulWidget {
  const AddPayment({Key? key}) : super(key: key);

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _addressController = TextEditingController();

  // Fetch user's address
  Future<void> _fetchUserAddress() async {
    final profileController = EditProfileController();
    final userData = await profileController.getUserData();
    if (userData != null && userData['address'] != null) {
      setState(() {
        _addressController.text = userData['address'];
      });
    }
  }

  // Show Date Picker for Expiry Date (MM/YYYY format)
  Future<void> _selectExpiryDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      String formattedDate =
          "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().substring(2)}";
      _expiryDateController.text = formattedDate;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldSpacing = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Add Payment',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: fieldSpacing),
              _buildLabel("Card Number", screenWidth),
              _buildTextField(
                controller: _cardNumberController,
                hint: "xxxx xxxx xxxx xxxx",
                keyboardType: TextInputType.number,
                inputFormatters: [CardNumberFormatter()],
              ),
              SizedBox(height: fieldSpacing),
              _buildLabel("Card Holder Name", screenWidth),
              _buildTextField(
                controller: _cardHolderNameController,
                hint: "John Doe",
              ),
              SizedBox(height: fieldSpacing),
              _buildLabel("Expiry Date", screenWidth),
              GestureDetector(
                onTap: _selectExpiryDate, // Open date picker on tap
                child: AbsorbPointer(
                  child: _buildTextField(
                    controller: _expiryDateController,
                    hint: "MM/YY",
                  ),
                ),
              ),
              SizedBox(height: fieldSpacing),
              _buildLabel("CVV", screenWidth),
              _buildTextField(
                controller: _cvvController,
                hint: "123",
                obscureText: true,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: fieldSpacing),
              _buildLabel("Billing Address", screenWidth),
              _buildTextField(
                controller: _addressController,
                hint: "123 Main Street",
              ),
              SizedBox(height: fieldSpacing * 2),
              _buildSaveButton(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build input labels
  Widget _buildLabel(String text, double screenWidth) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: screenWidth * 0.05,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    String? hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
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
            color: Colors.orange,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
    );
  }

  // Helper method to build Save button
  Widget _buildSaveButton(double screenWidth) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.25,
            vertical: screenWidth * 0.04,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
// In the AddPayment widget, modify the onPressed of the save button:
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            await PaymentsController().savePaymentDetails(
              cardNumber: _cardNumberController.text.trim(),
              cardHolderName: _cardHolderNameController.text.trim(),
              expiryDate: _expiryDateController.text.trim(),
              cvv: _cvvController.text.trim(),
              address: _addressController.text.trim(),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Payment details saved successfully!"),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to the Payment screen after saving
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Payment()),
            );
          }
        },
        child: Text(
          'Save Payment',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
