import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:baby_shop_hub/controllers/payments_controller.dart';
import 'package:baby_shop_hub/screens/add_payment.dart';
import 'package:baby_shop_hub/screens/edit_payment.dart';
import 'package:baby_shop_hub/components/custom_navbar.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final PaymentsController _paymentsController = PaymentsController();
  Map<String, dynamic>? paymentDetails;

  @override
  void initState() {
    super.initState();
    fetchPaymentDetails();
  }

  Future<void> fetchPaymentDetails() async {
    var details = await _paymentsController.getPaymentDetails();
    setState(() {
      paymentDetails = details;
    });
  }

  void navigateToEditPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditPayment()),
    ).then((_) {
      fetchPaymentDetails();
    });
  }

  void navigateToAddPayment() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddPayment()));
  }

  Future<void> deletePaymentDetails() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Payment Details'),
        content:
            const Text('Are you sure you want to delete your payment details?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      await _paymentsController.deletePaymentDetails();
      setState(() {
        paymentDetails = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment details deleted successfully!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth < 600
        ? screenWidth * 0.8
        : screenWidth * 0.6; // Dynamic button width based on screen size

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Your Card Details',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: paymentDetails == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No payment details found',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: navigateToAddPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 202, 133),
                        minimumSize: Size(buttonWidth, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5, // Adding shadow for a modern look
                      ),
                      child: const Text('Add Payment Details'),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add design and styling to card data
                  _buildPaymentDetail(
                      'Card Number', paymentDetails?['cardNumber']),
                  _buildPaymentDetail(
                      'Card Holder', paymentDetails?['cardHolderName']),
                  _buildPaymentDetail('MM/YYYY', paymentDetails?['expiryDate']),
                  _buildPaymentDetail('CVV', paymentDetails?['cvv']),
                  _buildPaymentDetail(
                      'Shipping Address', paymentDetails?['address']),
                  const SizedBox(height: 30),
                  // Buttons for edit and delete
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: navigateToEditPayment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 202, 133),
                            minimumSize: Size(buttonWidth, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: const Text('Edit Payment Details'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: deletePaymentDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(buttonWidth, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Delete Payment Details',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  // Helper method to build payment details
  Widget _buildPaymentDetail(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '$title: ',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                value ?? 'N/A',
                style: GoogleFonts.montserrat(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
