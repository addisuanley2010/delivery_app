import 'dart:io';
import 'package:delivery/models/location_model.dart';
import 'package:delivery/pages/login.dart';
import 'package:delivery/screens/wrapper.dart';
import 'package:delivery/services/locationService.dart';
import 'package:delivery/ui/client/component/modal_picture.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/auth.dart';

//this is comment
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String imageUrl = '';
  File? _imageFile;
  bool _isLoading = false;
  /////////////////////////////////////////////////////////////////////
  // text field state
  late String name, email, phone, address, password, confirmpassword;
  String pictureProfilePath = '';

  final AuthService _auth = AuthService();

  //TextController to read text entered in text field
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmpasswordController;
  late TextEditingController _addressController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmpasswordController = TextEditingController();
    _addressController = TextEditingController();

    super.initState();
  }

  void clearForm() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmpasswordController.clear();
    _addressController.clear();
  }

  String getPictureProfilePath() {
    return pictureProfilePath;
  }

  void setPictureProfilePath(String PictureProfilePath) {
    pictureProfilePath = PictureProfilePath;
    print(pictureProfilePath);
  }

  @override
  Widget build(BuildContext context) {
    Mylocation location;

    getLocation().then((data) {
      location = data;
      // print('latitude:  ${location.lat}');
      //print('longtude:  ${location.long}');
    });

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
          text: 'Create a Account',
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
              children: [
                const SizedBox(height: 10),
                Align(alignment: Alignment.center, child: pickImage()),
                const SizedBox(height: 10),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    controller: _nameController,
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
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
                      hintText: 'address',
                      hintStyle: TextStyle(
                        color: AppColors.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter address';
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
                    controller: _emailController,
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
                    controller: _phoneController,
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
                    controller: _passwordController,
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
                    controller: _confirmpasswordController,
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
                            if (_imageFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please select an image')));
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              Reference referenceRoot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  referenceRoot.child('profile');
                              String uniqueFileName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              Reference referenceImageToUpload =
                                  referenceDirImages.child(uniqueFileName);
                              await referenceImageToUpload.putFile(_imageFile!);

                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();

                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      name,
                                      email,
                                      phone,
                                      password,
                                      address,
                                      imageUrl);
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
                                      content:
                                          Text('Registerd successfully!')));
                              // ignore: use_build_context_synchronously
                              // Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Wrapper()),
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')));
                            }
                          }
                        },
                        child: const TextCustom(
                            text: ' Sign Up ',
                            color: ColorsFrave.primaryColor))),
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

  Widget pickImage() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey[300]!),
          shape: BoxShape.circle),
      child: InkWell(
        onTap: () async {
          ImagePicker imagePicker = ImagePicker();
          XFile? file =
              await imagePicker.pickImage(source: ImageSource.gallery);
          if (file == null) {
            return;
          }
          String uniqueFileName =
              DateTime.now().millisecondsSinceEpoch.toString();
          setState(() {
            _imageFile = File(file.path);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: _imageFile != null
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_imageFile!),
                    ),
                  ),
                )
              : const Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 115, 117, 196),
                    size: 58.0,
                  ),
                ),
        ),
      ),
    );
  }
}

class _PictureRegistre extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey[300]!),
          shape: BoxShape.circle),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => modalPictureRegister(
            ctx: context,
            onPressedChange: () async {
              final permissionGallery = await Permission.photos.request();

              switch (permissionGallery) {
                case PermissionStatus.granted:
                  Navigator.pop(context);
                  final XFile? imagePath =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (imagePath != null) {
                    _RegisterState().setPictureProfilePath(imagePath.path);
                  }
//getPictureProfilePath
                  break;
                case PermissionStatus.denied:
                case PermissionStatus.restricted:
                case PermissionStatus.limited:
                case PermissionStatus.permanentlyDenied:
                  openAppSettings();
                  break;
              }
            },
            onPressedTake: () async {
              final permissionPhotos = await Permission.camera.request();

              switch (permissionPhotos) {
                case PermissionStatus.granted:
                  Navigator.pop(context);
                  final XFile? photoPath =
                      await _picker.pickImage(source: ImageSource.camera);
                  // if (photoPath != null) OnSelectPictureEvent(photoPath.path);
                  if (photoPath != null) {
                    _RegisterState().setPictureProfilePath(photoPath.path);
                  }

                  break;

                case PermissionStatus.denied:
                case PermissionStatus.restricted:
                case PermissionStatus.limited:
                case PermissionStatus.permanentlyDenied:
                  openAppSettings();
                  break;
              }
            }),
        child: _RegisterState().getPictureProfilePath() == ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.wallpaper_rounded,
                      size: 60, color: ColorsFrave.primaryColor),
                  SizedBox(height: 10.0),
                  TextCustom(text: 'Picture', color: Colors.grey)
                ],
              )
            : Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                            File(_RegisterState().getPictureProfilePath())))),
              ),
      ),
    );
  }
}

class OnSelectPictureEvent {
  final String pictureProfilePath;

  OnSelectPictureEvent(this.pictureProfilePath);
}
