import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import '../components/form_field_frave.dart';
import 'package:delivery/services/database.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  final _keyForm = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> getPersonalInformation() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final customerRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(currentUser.uid);
      final customerSnapshot = await customerRef.get();
      final customerData = customerSnapshot.data() as Map<String, dynamic>;

      _nameController = TextEditingController(text: customerData['name']);
      _lastNameController =
          TextEditingController(text: customerData['lastName']);
      _phoneController = TextEditingController(text: customerData['phone']);
      _emailController = TextEditingController(text: customerData['email']);
      _addressController = TextEditingController(text: customerData['address']);
    }
  }

  @override
  void initState() {
    super.initState();
    getPersonalInformation();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 181, 74, 110),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: const [
              SizedBox(width: 10.0),
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColor, size: 17),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor)
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading
                ? null
                : () async {
                    if (_keyForm.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      final currentUser = FirebaseAuth.instance.currentUser;
                      try {
                        await DatabaseService(uid: currentUser!.uid)
                            .updateUserDataProfile(
                                _nameController.text,
                                _emailController.text,
                                _phoneController.text,
                                _lastNameController.text,
                                _addressController.text);
                        _showSnackbar('Account updated successfully');
                      } catch (error) {
                        _showSnackbar('Error updating account');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
            child: _isLoading
                ? const CircularProgressIndicator()
                : TextCustom(
                    text: 'Update account',
                    fontSize: 16,
                    color: Colors.amber[900]!,
                  ),
          )
        ],
      ),
      body: FutureBuilder(
          future: getPersonalInformation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            } else {
              return SafeArea(
                child: Form(
                    key: _keyForm,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      children: [
                        const TextCustom(
                            text: 'Name', color: ColorsFrave.secundaryColor),
                        const SizedBox(height: 5.0),
                        FormFieldFrave(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        const TextCustom(
                            text: 'Lastname',
                            color: ColorsFrave.secundaryColor),
                        const SizedBox(height: 5.0),
                        FormFieldFrave(
                          controller: _lastNameController,
                          hintText: 'lastname',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your father name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        const TextCustom(
                            text: 'Phone', color: ColorsFrave.secundaryColor),
                        const SizedBox(height: 5.0),
                        FormFieldFrave(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          hintText: '0912345678',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^09[0-9]{8}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        const TextCustom(
                            text: 'Email Address',
                            color: ColorsFrave.secundaryColor),
                        const SizedBox(height: 5.0),
                        FormFieldFrave(
                          controller: _emailController,
                          readOnly: true,
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
                        const TextCustom(
                            text: ' Address',
                            color: ColorsFrave.secundaryColor),
                        const SizedBox(height: 5.0),
                        FormFieldFrave(
                          controller: _addressController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Address';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              );
            }
          }),
    );
  }
}
