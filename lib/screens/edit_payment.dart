import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:baby_shop_hub/controllers/payments_controller.dart';

class EditPayment extends StatefulWidget {
  const EditPayment({super.key});

  @override
  State<EditPayment> createState() => _EditPaymentState();
}

class _EditPaymentState extends State<EditPayment> {
  final PaymentsController _paymentsController = PaymentsController();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Fetch payment details and prefill the fields
  Future<void> fetchPaymentDetails() async {
    var paymentDetails = await _paymentsController.getPaymentDetails();

    if (paymentDetails != null) {
      setState(() {
        _cardNumberController.text = paymentDetails['cardNumber'] ?? '';
        _cardHolderController.text = paymentDetails['cardHolderName'] ?? '';
        _expiryDateController.text = paymentDetails['expiryDate'] ?? '';
        _cvvController.text = paymentDetails['cvv'] ?? '';
        _addressController.text = paymentDetails['address'] ?? '';
      });
    }
  }

  // Save payment details
  Future<void> savePayment() async {
    await _paymentsController.savePaymentDetails(
      cardNumber: _cardNumberController.text.trim(),
      cardHolderName: _cardHolderController.text.trim(),
      expiryDate: _expiryDateController.text.trim(),
      cvv: _cvvController.text.trim(),
      address: _addressController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment details saved successfully')),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    fetchPaymentDetails();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Edit Payment',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    label: 'Card Number:',
                    controller: _cardNumberController,
                  ),
                  _buildInputField(
                    label: 'Card Holder Name:',
                    controller: _cardHolderController,
                  ),
                  _buildInputField(
                    label: 'Expiry Date:',
                    controller: _expiryDateController,
                  ),
                  _buildInputField(
                    label: 'CVV:',
                    controller: _cvvController,
                  ),
                  _buildInputField(
                    label: 'Address:',
                    controller: _addressController,
                  ),
                  SizedBox(height: screenHeight * 0.02), // Proportional spacing
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
                      onPressed: savePayment,
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.montserrat(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.045,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        SizedBox(height: screenHeight * 0.001), // Proportional spacing
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 0, 0),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 169, 169, 169),
                width: 2.0,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.015), // Proportional spacing
      ],
    );
  }
}
