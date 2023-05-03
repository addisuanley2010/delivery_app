import 'package:delivery/pages/register.dart';
import 'package:delivery/services/auth.dart';
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
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String errorMessage = '';

  double? deviceHeight, deviceWidth; //have no use now

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

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
                padding:  EdgeInsets.fromLTRB(deviceWidth !* 0.15, 0, deviceWidth! * 0.15, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black54),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(155, 9, 9, 9)),
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
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      style: const TextStyle(
                          color: Color.fromARGB(155, 24, 22, 22)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black54),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(155, 23, 22, 22)),
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
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      style: const TextStyle(
                        color: Color.fromARGB(155, 36, 31, 31),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight! * 0.04,
                    ),
                    SizedBox(
                      width: deviceWidth! * 0.85,
                      height: deviceHeight! * 0.05,
                      child: ElevatedButton(
                        child: const Text('   Sign In  '),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                         
                            if (result == null) {
                                setState(() => errorMessage = 'Could not sign in with those credentials');

                            } else {

                              Navigator.pop(context);
                            }
                          } else {
                           setState(() => errorMessage = 'Please enter valid form');
                          }
                        },
                      ),
                    ),
                    
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
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
                      width: deviceWidth! * 0.85,
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
                      width: deviceWidth! * 0.85,
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
                padding:  EdgeInsets.fromLTRB(deviceWidth !* 0.15, 0, deviceWidth! * 0.15, 0),
                child: SizedBox(
                  width: deviceWidth! * 0.85,
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




