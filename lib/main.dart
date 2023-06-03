import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/pages/registerAddress.dart';
import 'package:delivery/pages/registerEmailAndPassword.dart';
import 'package:delivery/ui/client/check_out_screen.dart';
import 'firebase_options.dart';
import 'package:delivery/screens/wrapper.dart';
import 'package:delivery/pages/registerShope.dart';
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
        ChangeNotifierProvider<AddressController>(
          create: (_) => AddressController(),
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
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: Container(
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/bg2.png'))),
          // child: const RegisterShopeInfo()),
          child: Wrapper()),

      // child: const CheckOutScreen()),
      routes: {
        // '/': (context) => const Wrapper(),
        '/checkoutPage': (context) => const CheckOutScreen(),
        // '/profilePage': (context) => ProfileScreen(),
        // '/settingsPage': (context) => SettingsScreen(),
      },
    );
  }
}
