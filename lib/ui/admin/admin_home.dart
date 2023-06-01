import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/admin/delivery/list_deliverys_screen.dart';
import 'package:delivery/ui/admin/orders_admin/orders_admin_screen.dart';
import 'package:delivery/ui/admin/products/list_products_screen.dart';
import 'package:flutter/material.dart';
import 'components/text_custom.dart';
import 'components/item_account.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/profile/edit_Prodile_screen.dart';
import 'package:delivery/ui/admin/profile/change_password_screen.dart';
import 'package:delivery/ui/admin/category/categories_admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'my_test/test.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  final AuthService _auth = AuthService();
  late String name;
  late String email;
  late String imageUrl;

  Future<void> getPersonalInformation() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final customerRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(currentUser.uid);
      final customerSnapshot = await customerRef.get();
      final customerData = customerSnapshot.data() as Map<String, dynamic>;
      name = customerData['name'];
      email = customerData['email'];
      imageUrl = customerData['imageUrl'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getPersonalInformation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error loading data'));
          } else {
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                children: [
                  Align(alignment: Alignment.center, child: imagepicker()),
                  const SizedBox(height: 10.0),
                  Center(
                      child: TextCustom(
                    text: name,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    maxLine: 1,
                    textAlign: TextAlign.center,
                  )),
                  const SizedBox(height: 5.0),
                  Center(
                      child: TextCustom(
                          text: email,
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
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      }),
                  ItemAccount(
                      text: 'Change Password',
                      icon: Icons.lock_rounded,
                      colorIcon: 0xff1B83F5,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      }),
                  // ItemAccount(
                  //     text: 'Change Role',
                  //     icon: Icons.swap_horiz_rounded,
                  //     colorIcon: 0xffE62755,
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //           builder: (context) => const SelectRoleScreen(),
                  //         ),
                  //       );
                  //     }),
                  // const ItemAccount(
                  //   text: 'Dark mode',
                  //   icon: Icons.dark_mode_rounded,
                  //   colorIcon: 0xff051E2F,
                  // ),
                  const SizedBox(height: 15.0),
                  const TextCustom(text: 'shop', color: Colors.grey),
                  const SizedBox(height: 10.0),
                  ItemAccount(
                      text: 'Categories',
                      icon: Icons.category_rounded,
                      colorIcon: 0xff5E65CD,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CategoriesAdminScreen(),
                          ),
                        );
                      }),
                  ItemAccount(
                      text: 'Products',
                      icon: Icons.add,
                      colorIcon: 0xff355773,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ListProductsScreen(),
                          ),
                        );
                      }),
                  ItemAccount(
                      text: 'Delivery',
                      icon: Icons.delivery_dining_rounded,
                      colorIcon: 0xff469CD7,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListDeliverysScreen(),
                          ),
                        );
                      }),
                  ItemAccount(
                      text: 'Orders',
                      icon: Icons.checklist_rounded,
                      colorIcon: 0xffFFA136,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrdersAdminScreen(),
                          ),
                        );
                      }),
                  const SizedBox(height: 15.0),
                  const TextCustom(text: 'Personal', color: Colors.grey),
                  const SizedBox(height: 10.0),
                  const ItemAccount(
                    text: 'Privacy & Policy',
                    icon: Icons.policy_rounded,
                    colorIcon: 0xff6dbd63,
                  ),
                  ItemAccount(
                      text: 'Security',
                      icon: Icons.lock_outline_rounded,
                      colorIcon: 0xff1F252C,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TestShop(),
                          ),
                        );
                      }),
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
            );
          }
        },
      ),
    );
  }

  Widget imagepicker() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid, color: Colors.grey[200]!),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          InkWell(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(5),
              child: IconButton(
                  onPressed: () {
                    //more task here , I will do it at the end of this month
                    //not mandatory
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.lightBlueAccent,
                    size: 30,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
