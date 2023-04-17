import 'package:delivery/pages/register.dart';
import 'package:delivery/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  double? deviceHeight, deviceWidth; //have no use now

  final myController = TextEditingController();
  final myPasswordController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    myPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: AppColors.appBarColor,
      ),
      backgroundColor: AppColors.accentColor,
      body: ListView(children: [
        Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please enter The Email And Password ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: myController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black54),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 9, 9, 9)),
                        ),
                        enabledBorder: OutlineInputBorder(),
                      ),
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
                      style: const TextStyle(
                          color: Color.fromARGB(255, 24, 22, 22)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: myPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black54),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 23, 22, 22)),
                        ),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 4) {
                          return 'Password must be at least 4 characters';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Color.fromARGB(255, 36, 31, 31),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight! * 0.04,
                    ),
                    SizedBox(
                      width: deviceWidth! * 0.75,
                      height: deviceHeight! * 0.05,
                      child: ElevatedButton(
                        child: const Text('   Sign In  '),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            // 'Are you sure you want to sign in ?${myController.text} and ${myPasswordController.text}'),

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight! * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: const Text(
                            'Forget Password ?',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight! * 0.01,
                    ),
                    SizedBox(
                      width: deviceWidth! * 0.75,
                      height: deviceHeight! * 0.05,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook),
                        label: const Text("Login With Facebook"),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight! * 0.02,
                    ),
                    SizedBox(
                      width: deviceWidth! * 0.75,
                      height: deviceHeight! * 0.05,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.email_rounded),
                        label: const Text("Login With Google"),
                      ),
                    ),
                  ],
                ),
              ),
              const Text("Have no Account  ?", style: AppTextStyle.headline1),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: deviceWidth! * 0.75,
                  height: deviceHeight! * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create Account",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
