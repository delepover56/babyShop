import 'package:baby_shop_hub/firebase/firebase_options.dart';
import 'package:baby_shop_hub/screens/homepage.dart';
import 'package:baby_shop_hub/screens/edit_profile.dart'; // Import your EditProfile screen
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'controllers/edit_profile_controller.dart'; // Import your controller

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCO9gDtAolAYrWr4HpIGoWU7u25ycCAyqQ",
      authDomain: "babyshop-b4cfe.firebaseapp.com",
      projectId: "babyshop-b4cfe",
      storageBucket: "babyshop-b4cfe.firebasestorage.app",
      messagingSenderId: "901846426479",
      appId: "1:901846426479:web:81927d1287abc4dac33e9a",
      measurementId: "G-CDFB3WX59D",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ChangeNotifierProvider(
        create: (_) => EditProfileController(), // This works now
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Baby Shop',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: Homepage(), // Keep your homepage as the default entry point
          routes: {
            '/editProfile': (_) => EditProfile(), // Add route for EditProfile
          },
        ),
      ),
    );
  }
}
