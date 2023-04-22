import 'package:delivery/models/user.dart';
import 'package:delivery/pages/home.dart';
import 'package:delivery/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('wrapper');
    final user = Provider.of<Users?>(context);

    // return either the Home or Authenticate widget  depend on user login or logout
    if (user == null) {
      print(user);
      return Home();
    } else {
      print(user);
      return HomeScreen();
    }
  }
}
