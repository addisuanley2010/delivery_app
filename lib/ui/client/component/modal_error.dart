import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void modalError(BuildContext context, String text, VoidCallback onPressed) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Row(
              children: const [
                TextCustom(
                    text: 'Delivery ',
                    color: ColorsFrave.primaryColor,
                    fontWeight: FontWeight.w500),
                TextCustom(text: 'App', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [Colors.white, Color(0xff30d598)])),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff15c880)),
                child: const Icon(FontAwesomeIcons.check,
                    color: Colors.white, size: 38),
              ),
            ),
            const SizedBox(height: 35.0),
            TextCustom(text: text, fontSize: 17, fontWeight: FontWeight.w400),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: onPressed,
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 248, 4, 4),
                    borderRadius: BorderRadius.circular(5.0)),
                child: const TextCustom(
                    text: 'Done', color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
