import 'package:chaithu/provider/auth_provider.dart';
import 'package:chaithu/screens/home_screen.dart';
import 'package:chaithu/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context,ap,child)
          {
            return ap.isSignedIn ? HomeScreen():WelcomeScreen();
          },
        ),
        title: "FlutterPhoneAuth",
      ),
    );
  }
}
