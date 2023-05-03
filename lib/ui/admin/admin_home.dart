import 'package:flutter/material.dart';
import 'components/text_custom.dart';
import 'components/item_account.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/profile/edit_Prodile_screen.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: [
            Align(alignment: Alignment.center, child: imagepicker()),
            const SizedBox(height: 10.0),
            Center(
                child: TextCustom(
              text: "Addisu  Anley".toUpperCase(),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              maxLine: 1,
              textAlign: TextAlign.center,
            )),
            const SizedBox(height: 5.0),
            const Center(
                child: TextCustom(
                    text: "addisu@gmail.com",
                    fontSize: 20,
                    color: AppColors.primaryColor)),
            const SizedBox(height: 15.0),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Account', color: Colors.grey),
            const SizedBox(height: 10.0),
            ItemAccount(
                text: 'Profile setting',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                }),
            ItemAccount(
                text: 'Change Password',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () {}),
            ItemAccount(
                text: 'Change Role',
                icon: Icons.swap_horiz_rounded,
                colorIcon: 0xffE62755,
                onPressed: () {}),
            const ItemAccount(
              text: 'Dark mode',
              icon: Icons.dark_mode_rounded,
              colorIcon: 0xff051E2F,
            ),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Restaurant', color: Colors.grey),
            const SizedBox(height: 10.0),
            ItemAccount(
                text: 'Categories',
                icon: Icons.category_rounded,
                colorIcon: 0xff5E65CD,
                onPressed: () {}),
            ItemAccount(
                text: 'Products',
                icon: Icons.add,
                colorIcon: 0xff355773,
                onPressed: () {}),
            ItemAccount(
                text: 'Delivery',
                icon: Icons.delivery_dining_rounded,
                colorIcon: 0xff469CD7,
                onPressed: () {}),
            ItemAccount(
                text: 'Orders',
                icon: Icons.checklist_rounded,
                colorIcon: 0xffFFA136,
                onPressed: () {}),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Personal', color: Colors.grey),
            const SizedBox(height: 10.0),
            const ItemAccount(
              text: 'Privacy & Policy',
              icon: Icons.policy_rounded,
              colorIcon: 0xff6dbd63,
            ),
            const ItemAccount(
              text: 'Security',
              icon: Icons.lock_outline_rounded,
              colorIcon: 0xff1F252C,
            ),
            const ItemAccount(
              text: 'Term & Conditions',
              icon: Icons.description_outlined,
              colorIcon: 0xff458bff,
            ),
            const ItemAccount(
              text: 'Help',
              icon: Icons.help_outline,
              colorIcon: 0xff4772e6,
            ),
            const Divider(),
            ItemAccount(
              text: 'Sign Out',
              icon: Icons.power_settings_new_sharp,
              colorIcon: 0xffF02849,
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget imagepicker() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey[200]!),
          shape: BoxShape.circle),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
