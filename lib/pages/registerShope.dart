import 'dart:io';
import 'package:delivery/models/location_model.dart';
import 'package:delivery/pages/login.dart';
import 'package:delivery/pages/registerAddress.dart';
import 'package:delivery/services/locationService.dart';
import 'package:delivery/ui/client/component/btn_frave.dart';
import 'package:delivery/ui/client/component/form_field_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth.dart';

//this is comment
class RegisterShopeInfo extends StatefulWidget {
  const RegisterShopeInfo({super.key});

  @override
  State<RegisterShopeInfo> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterShopeInfo> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String imageUrlLiscence = '';
  File? _imageFile;
  bool _isLoading = false;

  // text field state
  String email = '';
  String password = '';
  String errorMessage = '';
  bool showPassword = true;
  late String name, phone, address, confirmpassword;

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

  @override
  Widget build(BuildContext context) {
    Mylocation location;

    L().getLocation().then((data) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                //form fields
                const TextCustom(text: 'business Name:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _nameController,
                  hintText: 'your business name',
                  prefixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your bussiness Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'business phone:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _phoneController,
                  hintText: '05562....',
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter phone';
                    }
                    if (value.length != 10) {
                      return 'Please a Enter correct length';
                    }
                    if (!RegExp("^0[0-9]").hasMatch(value)) {
                      return 'Please a valid  phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Your Trade Liscence'),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
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
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: _imageFile !=
                              null // Show the selected image if there is one
                          ? Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_imageFile!),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Tap and insert your  trade liscence image',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                ),
                              ),
                            )),
                ),
                const SizedBox(height: 20.0),
                BtnFrave(
                  text: 'next',
                  fontSize: 21,
                  height: 50,
                  fontWeight: FontWeight.w500,
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
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        await referenceImageToUpload.putFile(_imageFile!);

                        imageUrlLiscence =
                            await referenceImageToUpload.getDownloadURL();

                        setState(() {
                          _isLoading = false;
                        });

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterAddress(
                                    phone: _phoneController.text,
                                    imageUrlLiscence: imageUrlLiscence,
                                    name: _nameController.text,
                                  )),
                        );

                        // ignore: use_build_context_synchronously
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Registerd successfully!')));
                        // ignore: use_build_context_synchronously
                        // Navigator.pop(context);
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









///////
//  const TextCustom(text: 'Category'),
//             const SizedBox(height: 5.0),
//             Container(
//               height: 50,
//               width: MediaQuery.of(context).size.width,
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//               decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8.0)),
//               child: Container(
//                 padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.grey, blurRadius: 7, spreadRadius: -5.0)
//                     ]),
                
//                 child: InkWell(
//                   onTap: () async {
//                     final categories = await FirebaseFirestore.instance
//                         .collection('catagory')
//                         .get()
//                         .then((querySnapshot) => querySnapshot.docs
//                             .map((doc) =>
//                                 {'id': doc.id, 'name': doc.data()['name']})
//                             .toList());
//                     // ignore: use_build_context_synchronously
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: categories.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             final category = categories[index];
//                             print(category['id']);
//                             return ListTile(
//                               title: Text(category['name']),
//                               onTap: () {
//                                 setState(() {
//                                   _selectedCategory = category['id'];
//                                   _selectedName = category['name'];
//                                 });
//                                 Navigator.pop(context);
//                               },
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 3.0),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.category),
//                         const SizedBox(width: 25.0),
//                         Expanded(
//                           child: Text(
//                             _selectedCategory == null
//                                 ? 'Select a category'
//                                 : 'Category: $_selectedName',
//                             style: const TextStyle(fontSize: 16.0),
//                           ),
//                         ),
//                         const Icon(Icons.arrow_drop_down),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),