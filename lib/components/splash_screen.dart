import 'package:baby_shop_hub/screens/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 240, 225),
        ),
        child: Center(
          child: Text(
            'Baby Shop',
            style: GoogleFonts.getFont(
              'Jua',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade200,
            ),
          ),
        ),
      ),
    );
  }
}
