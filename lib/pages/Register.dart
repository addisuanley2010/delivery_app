import 'package:delivery/pages/Login.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
// import '../screens/loginScreen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String name, email, phone, address;

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    onSaved: (value) {
                      name = value!;
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
                    onSaved: (value) {
                      email = value!;
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
                    onSaved: (value) {
                      phone = value!;
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
                    onSaved: (value) {
                      address = value!;
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
                    controller: password,
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
                    controller: confirmpassword,
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
                      print(password.text);

                      print(confirmpassword.text);

                      if (password.text != confirmpassword.text) {
                        return "Password does not match";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print("successful");

                        return;
                      } else {
                        print("UnSuccessfull");
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
