import 'dart:io';
import 'package:delivery/models/location_model.dart';
import 'package:delivery/pages/login.dart';
import 'package:delivery/pages/registerEmailAndPassword.dart';
import 'package:delivery/screens/wrapper.dart';
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
class RegisterAddress extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? imageUrlLiscence;

  const RegisterAddress({
    super.key,
    required this.name,
    this.phone,
    this.imageUrlLiscence,
  });

  @override
  State<RegisterAddress> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterAddress> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String imageUrlAddress = '';
  File? _imageFile;
  bool _isLoading = false;

  // text field state
  String email = '';
  String password = '';
  String errorMessage = '';
  bool showPassword = true;
  late String confirmpassword;

  final AuthService _auth = AuthService();

  //TextController to read text entered in text field
  late TextEditingController _regionController;
  late TextEditingController _zoneController;
  late TextEditingController _weredaController;
  late TextEditingController _kebeleController;
  late TextEditingController _houseNumController;
  late TextEditingController _friendAddressController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _regionController = TextEditingController();
    _zoneController = TextEditingController();
    _weredaController = TextEditingController();
    _kebeleController = TextEditingController();
    _houseNumController = TextEditingController();
    _friendAddressController = TextEditingController();

    super.initState();
  }

  void clearForm() {
    _regionController.clear();
    _zoneController.clear();
    _weredaController.clear();
    _kebeleController.clear();
    _houseNumController.clear();
    _friendAddressController.clear();
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
          text: 'Enter your address information',
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
                const TextCustom(text: 'region:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _regionController,
                  hintText: 'zone',
                  prefixIcon: Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your Region';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                const TextCustom(text: 'Zone/kifle ketemae:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _zoneController,
                  hintText: 'zone',
                  prefixIcon: Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your zone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'your wereda:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _weredaController,
                  hintText: 'wereda',
                  prefixIcon: Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your wereda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'your kebele:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _kebeleController,
                  hintText: 'kebele',
                  prefixIcon: Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your kebele';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'your house number:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _houseNumController,
                  hintText: 'house number',
                  prefixIcon: Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your house number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'your friendly Address:'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _friendAddressController,
                  hintText: 'friendly Address',
                  prefixIcon: Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your friendly Address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20.0),
                const TextCustom(text: 'Your address Identification photo'),
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
                                'Tap and insert ddress Identification photo',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                ),
                              ),
                            )),
                ),

                const SizedBox(height: 20),
                BtnFrave(
                  text: 'Next',
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

                        imageUrlAddress =
                            await referenceImageToUpload.getDownloadURL();

                        setState(() {
                          _isLoading = false;
                        });

                        await _auth.registerWithEmailAndPassword(
                            _zoneController.text,
                            _weredaController.text,
                            _kebeleController.text,
                            _houseNumController.text,
                            _friendAddressController.text,
                            imageUrlAddress);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterShope(
                                    phone: widget.phone,
                                    imageUrlLiscence: widget.imageUrlLiscence,
                                    name: widget.name,
                                    zone: _zoneController.text,
                                    friendlyAddress:
                                        _friendAddressController.text,
                                    imageUrlAddress: imageUrlAddress,
                                    kebele: _kebeleController.text,
                                    houseNumber: _houseNumController.text,
                                    region: _regionController.text,
                                    wereda: _weredaController.text,
                                  )),
                        );

                        // ignore: use_build_context_synchronously
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Registerd successfully!')));
                        // ignore: use_build_context_synchronously
                        // Navigator.pop(context);
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Wrapper()),
                        // );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $error')));
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}









///////
//  const TextCustom(text: 'region'),
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