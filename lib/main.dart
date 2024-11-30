import 'package:baby_shop_hub/firebase/firebase_options.dart';
import 'package:baby_shop_hub/screens/cart.dart';
import 'package:baby_shop_hub/screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:baby_shop_hub/screens/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _setScreen() {
    switch (_selectedIndex) {
      case 0:
        return Homepage(
          selectedIndex: _selectedIndex,
          onTap: _onTap,
        );
      case 1:
        return Cart(
          selectedIndex: _selectedIndex,
          onTap: _onTap,
        );
      case 2:
        return Profile(
          selectedIndex: _selectedIndex,
          onTap: _onTap,
        );
      default:
        return Homepage(
          selectedIndex: _selectedIndex,
          onTap: _onTap,
        );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Baby Shop',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: _setScreen(),
      ),
    );
  }
}
