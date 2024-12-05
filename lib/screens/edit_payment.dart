import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Payment Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(labelText: 'Card Number'),
            ),
            TextField(
              controller: _cardHolderController,
              decoration: const InputDecoration(labelText: 'Card Holder Name'),
            ),
            TextField(
              controller: _expiryDateController,
              decoration: const InputDecoration(labelText: 'Expiry Date'),
            ),
            TextField(
              controller: _cvvController,
              decoration: const InputDecoration(labelText: 'CVV'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: savePayment,
              child: const Text('Save Payment Details'),
            ),
          ],
        ),
      ),
    );
  }
}
