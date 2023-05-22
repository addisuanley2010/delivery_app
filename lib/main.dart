import 'package:delivery/models/cartModel.dart';
import 'firebase_options.dart';
import 'package:delivery/screens/wrapper.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<Users?>(
          create: (_) => AuthService().user,
          initialData: null,
          catchError: (_, err) => null,
        ),
        ChangeNotifierProvider<CartController>(
          create: (_) => CartController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration:const  BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg2.png'))
        ),
        child: const Wrapper()),
    );
  }
}
