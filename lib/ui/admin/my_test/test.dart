import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('shopping_list');
  String imageUrl = '';
  File? _imageFile;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: key,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerName,
                    decoration:
                        InputDecoration(hintText: 'Enter the name of the item'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the item name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerQuantity,
                    decoration: const InputDecoration(
                        hintText: 'Enter the quantity of the item'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the item quantity';
                      }
                      return null;
                    },
                  ),
                  Stack(
                    children: [
                      IconButton(
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (file == null) {
                              print('no data selected');
                              return;
                            }
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            setState(() {
                              _imageFile = File(file.path);
                            });
                          },
                          icon: Icon(Icons.camera_alt)),
                      if (_imageFile != null)
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_imageFile!),
                            ),
                          ),
                        ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select an image')));
                        return;
                      }
                      setState(() {
                        _isLoading = true;
                      });
                      String itemName = _controllerName.text;
                      String itemQuantity = _controllerQuantity.text;
                      try {
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        await referenceImageToUpload.putFile(_imageFile!);


                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();


                        Map<String, String> dataToSend = {
                          'name': itemName,
                          'quantity': itemQuantity,
                          'image': imageUrl,
                        };
                        await _reference.add(dataToSend);
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Item added successfully')));
                        
                        _controllerName.clear();
                        _controllerQuantity.clear();
                        setState(() {
                          _imageFile = null;
                        });
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $error')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                  ///////////////////
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
