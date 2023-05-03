import 'package:delivery/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/const.dart';
import 'package:delivery/models/user.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // text field state
  late String name, email, phone, address, password, confirmpassword;
  final AuthService _auth = AuthService();

  //TextController to read text entered in text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFC6011),
        title: const Text('Sign up form '),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.deepPurple,
       
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Add your details to sign up",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
                      hintText: 'full name Name',
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email',
                      prefixIcon: Icon(Icons.email),
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please a Enter';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'phone number ',
                      prefixIcon: Icon(Icons.phone),
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please a Enter';
                      }
                      if (value.length != 10) {
                        return 'Please a Enter correct length';
                      }
                      if (!RegExp("^0[0-9]").hasMatch(value)) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => phone = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'address',
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => address = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'password',
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please a Enter';
                      }
                      if (value.length < 6) {
                        return 'Please a Enter correct length';
                      }

                      return null;
                    },
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'confirm password',
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please re-enter password';
                      }

                      if (password != confirmpassword) {
                        return "Password does not match";
                      }

                      return null;
                    },
                    onChanged: (val) {
                      setState(() => confirmpassword = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        //print("successful");
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                email, password, name, phone, address);
                        if (result == null) {
                          print('null');
                          //setState(() {});
                        } else {
                          print('success full');
                          Users user = result;
                          print(user.uid);
                        }
                      } else {
                        print("please fill the form correctly");
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account?"),
                      //onTap: () => Navigator.pushNamed(context, '/Register'),
                      TextButton(
                        onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          )
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
