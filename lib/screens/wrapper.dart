import 'package:delivery/models/user.dart';
import 'package:delivery/pages/home.dart';
import 'package:delivery/screens/select_role.dart';
import 'package:delivery/services/database.dart';
import 'package:delivery/ui/admin/admin_home.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/delivery/deliveryHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    String role = '';
  
    if (user == null) {
      return const Home();
    } else {
      //get role
      return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Data is available, use it
            UserData userData = snapshot.data!;
            role = userData.role;
            print('role in builder: ${role}');
            if (role == 'admin') {
              print(Text('Hello ${userData.name}!'));
              print(Text('your role is  ${userData.role}!'));
              return AdminHome();
            } else if (role == 'user') {
              print(Text('Hello ${userData.name}!'));
              print(Text('your role is  ${userData.role}!'));
              return ClientHomeScreen();
            } else {
              print(Text('Hello ${userData.name}!'));
              print(Text('your role is  ${userData.role}!'));
              return const DeliveryHome();
            }
          } else if (snapshot.hasError) {
            // Error retrieving data
            return Text('Error: ${snapshot.error}');
          } else {
            // Data is not yet available
            return Container(child: const CircularProgressIndicator());
          }
        },
      );
    }
  }
}
