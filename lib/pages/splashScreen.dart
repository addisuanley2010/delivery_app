import 'package:delivery/screens/wrapper.dart';
import 'package:delivery/ui/client/guestPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  Future<void> initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      await loadDataFromFirebase(); // Load data from Firebase or other sources

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          // Redirect to guest page (product view)
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GuestHomeScreen()),
            );
          });
        } else {
          // Redirect to home screen
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Wrapper()),
            );
          });
        }
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Future<void> loadDataFromFirebase() async {
    // Load your data from Firebase or other sources
    await Future.delayed(Duration(seconds: 3));
    // Simulating data loading delay
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      // Display error message or redirect to an error screen
      return const Scaffold(
        body: Center(
          child: Text('Error occurred while initializing Firebase.'),
        ),
      );
    }

    if (!_initialized) {
      // Display loading spinner or splash screen widget
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      // Your app's home screen widget
      body: Container(
          // Your app's home screen content
          ),
    );
  }
}
