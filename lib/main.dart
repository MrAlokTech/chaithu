import 'package:chaithu/provider/auth_provider.dart';
import 'package:chaithu/screens/home_screen.dart';
import 'package:chaithu/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      child:  const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
        title: "FlutterPhoneAuth",
      ),
    );
  }
}

///
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          /// Show loading indicator while checking the authentication state.
          /// This will be popup as we start the application
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            /// User is already logged in, navigate to HomeScreen.
            return const HomeScreen();
          } else {
            // User is not logged in yet! Navigating to WelcomeScreen.
            return const WelcomeScreen();
          }
        }
      },
    );
  }
}
