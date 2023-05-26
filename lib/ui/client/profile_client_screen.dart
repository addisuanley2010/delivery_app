import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/pages/home.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/ui/admin/components/item_account.dart';
import 'package:delivery/ui/admin/profile/change_password_screen.dart';
import 'package:delivery/ui/admin/profile/edit_Prodile_screen.dart';
import 'package:delivery/ui/client/client_orders_screen.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/bottom_navigation_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:delivery/ui/client/selectShopScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileClientScreen extends StatelessWidget {
  ProfileClientScreen({super.key});
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
    //final authBloc = BlocProvider.of<AuthBloc>(context);
    //final streamuser = BlocProvider.of<AuthBloc>(context);
    final user = Provider.of<Users?>(context);

    // if (user == null) {
    //     return const Home();
    //   } else {
    //     return const SelectRoleScreen();
    //   }

    return
        // StreamListener<AuthBloc, AuthState>
        Container(
      // listener: (context, state) {
      //   if (state is LoadingAuthState) {
      //     modalLoading(context);
      //   } else if (state is SuccessAuthState) {
      //     Navigator.pop(context);
      //     modalSuccess(
      //         context,
      //         'Picture Change Successfully',
      //         () => Navigator.pushReplacement(
      //             context, routeFrave(page: const ProfileClientScreen())));
      //     Navigator.pop(context);
      //   } else if (state is FailureAuthState) {
      //     Navigator.pop(context);
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //         content: TextCustom(text: state.error, color: Colors.white),
      //         backgroundColor: Colors.red));
      //   }
      // },
      child: Scaffold(
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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    children: [
                      const SizedBox(height: 20.0),
                      const Align(
                          alignment: Alignment.center,
                          child: Text('imagepicker') //ImagePickerFrave()
                          ),
                      const SizedBox(height: 20.0),
                      Center(
                          child: TextCustom(
                              text: '$name',
                              fontSize: 25,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5.0),
                      Center(
                          child: TextCustom(
                              text: '$email',
                              fontSize: 20,
                              color: Colors.grey)),
                      const SizedBox(height: 15.0),
                      const TextCustom(text: 'Account', color: Colors.grey),
                      const SizedBox(height: 10.0),
                      ItemAccount(
                        text: 'Profile setting',
                        icon: Icons.person,
                        colorIcon: 0xff01C58C,
                        onPressed: () => Navigator.push(context,
                            routeFrave(page: const EditProfileScreen())),
                      ),
                      ItemAccount(
                        text: 'Change Password',
                        icon: Icons.lock_rounded,
                        colorIcon: 0xff1B83F5,
                        onPressed: () => Navigator.push(context,
                            routeFrave(page: const ChangePasswordScreen())),
                      ),
                      const ItemAccount(
                        text: 'Add addresses',
                        icon: Icons.my_location_rounded,
                        colorIcon: 0xffFB5019,
                        // onPressed: () => Navigator.push(
                        //     context, routeFrave(page: SelectShopScreen())
                        //     ),
                      ),
                      ItemAccount(
                        text: 'select addresss',
                        icon: Icons.my_location_rounded,
                        colorIcon: 0xffFB5019,
                        onPressed: () => Navigator.push(
                            context, routeFrave(page: SelectShopScreen())),
                      ),
                      ItemAccount(
                        text: 'Orders',
                        icon: Icons.shopping_bag_outlined,
                        colorIcon: 0xffFBAD49,
                        onPressed: () => Navigator.push(
                            context, routeFrave(page: ClientOrdersScreen())),
                      ),
                      const ItemAccount(
                        text: 'Dark mode',
                        icon: Icons.dark_mode_rounded,
                        colorIcon: 0xff051E2F,
                      ),
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
                          // authBloc.add(LogOutEvent());
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     routeFrave(page: CheckingLoginScreen()),
                          //     (route) => false);

                          await _auth.signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
        bottomNavigationBar: const BottomNavigationFrave(3),
      ),
    );
  }
}
