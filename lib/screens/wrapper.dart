import 'package:delivery/models/user.dart';
import 'package:delivery/pages/home.dart';
import 'package:delivery/services/database.dart';
import 'package:delivery/ui/admin/admin_home.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/delivery/delivery_home_screen.dart';
// import 'package:delivery/ui/delivery/deliveryHome.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthService a = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    //String role = '';

    if (user == null) {
      print('at wraper   user:null');
      return const Home();
    } else {
      //get role
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), fit: BoxFit.cover),
        ),
        child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Data is available, use it
                UserData userData = snapshot.data!;
                String role = userData.role;
                print(role);
                if (role == 'admin') {
                  print('home admin called');
                  
                  return AdminHome();
                } else if (role == 'user') {
                  return ClientHomeScreen();
                } else {
                  return DeliveryHomeScreen();
                }
              } else if (snapshot.hasError) {
                print(
                    'error ocured while fetching customer data,may be undefine filed mapping');
                // return const Scaffold(
                //     backgroundColor: Colors.white54, body: Text('loading...'));
                return const Home();
              } else {
                // Data is not yet available
                return const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 208, 213, 218)),
                      semanticsLabel: 'Loading',
                    ),
                  ),
                );
              }
            }),
      );
    }
  }
}
