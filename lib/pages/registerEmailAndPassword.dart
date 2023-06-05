import 'package:delivery/models/location_model.dart';
import 'package:delivery/pages/login.dart';
import 'package:delivery/screens/wrapper.dart';
import 'package:delivery/services/locationService.dart';
import 'package:delivery/ui/client/component/btn_frave.dart';
import 'package:delivery/ui/client/component/form_field_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import '../services/auth.dart';

//this is comment
class RegisterShope extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? imageUrlLiscence;
  final String? region;
  final String? zone;
  final String? wereda;
  final String? kebele;
  final String? friendlyAddress;
  final String? imageUrlAddress;
  final String? houseNumber;
  final String? addressId;

  const RegisterShope(
      {super.key,
      required this.name,
      required this.phone,
      required this.imageUrlLiscence,
      required this.region,
      required this.zone,
      required this.wereda,
      required this.kebele,
      required this.friendlyAddress,
      required this.imageUrlAddress,
      required this.houseNumber,
      required this.addressId});

  @override
  State<RegisterShope> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterShope> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading = false;

  // text field state
  //String email = '';
  //String password = '';
  String errorMessage = '';
  bool showPassword = true;
  late String confirmpassword;

  final AuthService _auth = AuthService();

  //TextController to read text entered in text field

  late TextEditingController _passwordController;
  late TextEditingController _confirmpasswordController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  final _keyForm = GlobalKey<FormState>();
  String? addressId = '';
  Mylocation location = Mylocation(lat: 0, long: 0);

  @override
  void initState() {
    L().getLocation().then((data) {
      location = data;
      print('here placelatitude of device:  ${location.lat}');
      print('here place longtude of device:  ${location.long}');
    });

    _passwordController = TextEditingController();
    _confirmpasswordController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();

    super.initState();
  }

  void clearForm() {
    _passwordController.clear();
    _confirmpasswordController.clear();
    _addressController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            clearForm();
          },
          child: Container(
              alignment: Alignment.center,
              child: const TextCustom(
                  text: 'Cancel',
                  color: ColorsFrave.primaryColor,
                  fontSize: 15)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        title: const TextCustom(
          text: 'Create a Authentication',
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 254, 255),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                //form fields

                const SizedBox(height: 20.0),
                const TextCustom(text: 'Business Email:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _emailController,
                  hintText: 'email@bdu.com',
                  prefixIcon: const Icon(Icons.email),
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

                const SizedBox(height: 20.0),
                const TextCustom(text: 'Password'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _passwordController,
                  hintText: '********',
                  isPassword: showPassword,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
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
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Confirm Password'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _confirmpasswordController,
                  hintText: 'confirm your password',
                  isPassword: showPassword,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please re-enter password';
                    }

                    if (_passwordController.text !=
                        _confirmpasswordController.text) {
                      return "Password does not match";
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
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BtnFrave(
                  text: 'sign up',
                  fontSize: 21,
                  height: 50,
                  fontWeight: FontWeight.w500,
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        print('calling insert address to get address Id');
                        addressId = await LocationInsert().addAdress(
                            latitude: location.lat,
                            longitude: location.long,
                            name: widget.name!);
                        if (addressId != null) {
                          print(
                              'Address inserted with document ID: $addressId');
                        } else {
                          print('Failed to insert address');
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $error')));
                      }

                      try {
                        print(
                            'after address inserted , trying to add all data to customer table with above address id');
                        dynamic result = await _auth.registerAdmin(
                            name: widget.name,
                            phone: widget.phone,
                            imageUrlLiscence: widget.imageUrlLiscence,
                            region: widget.region,
                            zone: widget.zone,
                            wereda: widget.wereda,
                            kebele: widget.kebele,
                            friendlyAddress: widget.friendlyAddress,
                            houseNumber: widget.houseNumber,
                            imageUrlAddress: widget.imageUrlAddress,
                            addressId: addressId,
                            email: _emailController.text,
                            password: _passwordController.text

                            // imageUrlLiscence
                            );
                        if (result == null) {
                          //         print('null');
                        } else {
                          Navigator.pop(context);
                        }

                        setState(() {
                          _isLoading = false;
                        });

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Registerd successfully!')));
                        // ignore: use_build_context_synchronously
                        // Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Wrapper()),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $error')));
                      }
                    }
                  },
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
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
