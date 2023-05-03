import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/client/client_home.dart';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/admin_home.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextCustom(
                      text: 'Food ',
                      fontSize: 25,
                      color: ColorsFrave.primaryColor,
                      fontWeight: FontWeight.w500),
                  TextCustom(
                      text: 'Delivery',
                      fontSize: 25,
                      color: ColorsFrave.secundaryColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              const SizedBox(height: 20.0),
              const TextCustom(
                text: 'How do you want to continue?',
                color: ColorsFrave.secundaryColor,
                fontSize: 25,
              ),
              const SizedBox(height: 30.0),
              _BtnRol(
                svg: 'assets/svg/restaurante.svg',
                text: 'Restaurant Admin',
                color1: ColorsFrave.primaryColor.withOpacity(.2),
                color2: Colors.greenAccent.withOpacity(.1),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdminHome(),
                    ),
                  )
                },
              ),
              _BtnRol(
                svg: 'assets/svg/bussiness-man.svg',
                text: 'Client',
                color1: const Color(0xffFE6488).withOpacity(.2),
                color2: Colors.amber.withOpacity(.1),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClientHomeScreen(),
                    ),
                  )
                },
              ),
              _BtnRol(
                svg: 'assets/svg/delivery-bike.svg',
                text: 'Delivery',
                color1: const Color(0xff8956FF).withOpacity(.2),
                color2: Colors.purpleAccent.withOpacity(.1),
                // onPressed: () => Navigator.pushAndRemoveUntil(context, routeFrave(page: DeliveryHomeScreen()), (route) => false),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnRol extends StatelessWidget {
  final String svg;
  final String text;
  final Color color1;
  final Color color2;
  final VoidCallback? onPressed;

  const _BtnRol(
      {required this.svg,
      required this.text,
      required this.color1,
      required this.color2,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onPressed,
        child: Container(
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft, colors: [color1, color2]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  svg,
                  height: 100,
                ),
                TextCustom(
                    text: text, fontSize: 20, color: ColorsFrave.secundaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
