import 'package:flutter/material.dart';
import 'package:delivery/ui/admin/components/btn_frave.dart';
import 'package:delivery/ui/admin/components/form_field_frave.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/pages/register.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/ui/admin/components/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;

  String email = '';
  String password = '';
  String errorMessage = '';
  bool showPassword = true;

//   double? deviceHeight, deviceWidth; //have no use now

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //     deviceHeight = MediaQuery.of(context).size.height;
    //     deviceWidth = MediaQuery.of(context).size.width;
    return loading
        ? const Loadnig()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Form(
                key: _keyForm,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(100.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  shape: BoxShape.circle),
                              child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.black,
                                  size: 20),
                            ),
                          ),
                          Row(
                            children: const [
                              TextCustom(
                                  text: 'online  ',
                                  color: ColorsFrave.primaryColor,
                                  fontWeight: FontWeight.w500),
                              TextCustom(
                                  text: 'Delivery',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Image.asset('assets/images/food-delivery-marker.png',
                        height: 150),
                    const SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.center,
                      child: const TextCustom(
                          text: 'Welcome back!',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff14222E)),
                    ),
                    const SizedBox(height: 5.0),
                    const Align(
                      alignment: Alignment.center,
                      child: TextCustom(
                          text:
                              'Use your credentials below and login to your account.',
                          textAlign: TextAlign.center,
                          color: Colors.grey,
                          maxLine: 2,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 50.0),
                    const TextCustom(text: 'Email Address'),
                    const SizedBox(height: 5.0),
                    FormFieldFrave(
                      controller: _emailController,
                      hintText: 'email@bdu.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else {
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                        }
                        return null;
                      },
                      
                    ),
                    const SizedBox(height: 20.0),
                    const TextCustom(text: 'Password'),
                    const SizedBox(height: 5.0),
                    FormFieldFrave(
                      controller: _passwordController,
                      hintText: '********',
                      isPassword: showPassword,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 4) {
                          return 'Password must be at least 4 characters';
                        }
                        return null;
                      },
                        suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            InkWell(
                                // onTap: () => Navigator.push(context, routeFrave(page: ForgotPasswordScreen())),
                                child: TextCustom(
                                    text: 'Forgot Password?',
                                    fontSize: 17,
                                    color: ColorsFrave.primaryColor)),
                          ],
                        )),
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    BtnFrave(
                      text: 'Login',
                      fontSize: 21,
                      height: 50,
                      fontWeight: FontWeight.w500,
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text);
                          if (result == null) {
                            setState(() => {
                                  loading = false,
                                  errorMessage =
                                      'Could not sign in with those credentials'
                                });
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 40.0),
                    BtnFrave(
                      text: 'continue with google ',
                      fontSize: 21,
                      height: 50,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 67, 90, 241),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const TextCustom(
                            text: 'create new Account?',
                            fontSize: 17,
                            color: ColorsFrave.primaryColor)),
                  ],
                ),
              ),
            ),
          );
  }
}
