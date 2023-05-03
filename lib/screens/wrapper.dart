import 'package:delivery/models/user.dart';
import 'package:delivery/pages/home.dart';
import 'package:delivery/screens/select_role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    // return either the Home or Authenticate widget  depend on user login or logout
    if (user == null) {
      return const Home();
    } else {
      return const SelectRoleScreen();
    }
  }
}
