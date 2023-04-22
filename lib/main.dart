import 'firebase_options.dart';
import 'package:delivery/screens/wrapper.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
// create connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// await Firebase.initializeApp(
// // Replace with actual values
// options: const FirebaseOptions(
//   apiKey: "api key here",
//   appId: "app id here",
//   messagingSenderId: "messaging id",
//   projectId: "project id here",
// ),

  //  static const FirebaseOptions android = FirebaseOptions(
  //   apiKey: 'AIzaSyDbonn6VEvIFDU4HkDMRBbWspYoFzl6Xns',
  //   appId: '1:969447912901:android:7351dad3a342c5c52b87ac',
  //   messagingSenderId: '969447912901',
  //   projectId: 'delivery-app-c7be9',
  //   storageBucket: 'delivery-app-c7be9.appspot.com',
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('main');

    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, err) => null,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
