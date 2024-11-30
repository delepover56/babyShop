import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Homepage extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTap;
  const Homepage({super.key, required this.selectedIndex, required this.onTap});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome User',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedMenu04,
            color: Colors.black,
            size: 24.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedNotification02,
              color: Colors.black,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of search bar
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "What Are You Looking For?",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: widget.selectedIndex,
        onTap: widget.onTap,
      ),
    );
  }
}
