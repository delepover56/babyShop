import 'package:baby_shop_hub/components/custom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _capitalizeFirstLetter(String name) {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  User? currentUser;
  @override
  void initState() {
    super.initState();
    _currentUserStatus();
  }

  void _currentUserStatus() {
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  int selectedIndex = 0; // Add this line to manage the selected index

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Welcome ${_capitalizeFirstLetter(currentUser?.displayName ?? "User")}',
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
                // Search Bar
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
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedFilterMailCircle,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),

                // TabBar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 202, 133),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        child: Text('All items'),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 202, 133),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        child: Text('Baby'),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 202, 133),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        child: Text('Toddler'),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 202, 133),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        child: Text('Kids'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),

                // Placeholder for content under each tab
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFFFE4C7), // Light orange background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Add some padding for better alignment
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NEW BABY',
                              style: GoogleFonts.jua(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                // Matches the theme
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'NEW MOM',
                              style: GoogleFonts.jua(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                // Matches the theme
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/NewBaby.png',
                          height: 150, // Adjust height as needed
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'For You',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio:
                        0.67, // Adjust for card height/width ratio
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/Images/Bunny.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: 6),
                          SizedBox(height: 5),
                          // Product Name
                          Text(
                            'Bunny', // Replace with actual product name
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 3),
                          // Product Price
                          Text(
                            '\$12', // Replace with actual product price
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 3),
                          // Rating and Favorite Icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 12),
                                  SizedBox(width: 3),
                                  Text(
                                    '4.5', // Replace with actual product rating
                                    style: GoogleFonts.montserrat(fontSize: 12),
                                  ),
                                ],
                              ),
                              Icon(Icons.favorite_border,
                                  size: 16, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}
