
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/user.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/admin/components/form_field_frave.dart';
import 'package:delivery/services/database.dart';
import 'package:provider/provider.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  final _keyForm = GlobalKey<FormState>();

  String? _selectedCategory;

  String? imageUrl; // Add imageUrl variable

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.clear();
    _nameController.dispose();
    _descriptionController.clear();
    _descriptionController.dispose();
    _priceController.clear();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Add New Product'),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(
          child: const TextCustom(
              text: 'Cancel', color: ColorsFrave.primaryColor, fontSize: 17),
          onPressed: () {
            Navigator.pop(context);
            // productBloc.add(OnUnSelectCategoryEvent());
            // productBloc.add(OnUnSelectMultipleImagesEvent());
          },
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                DatabaseService databaseService =
                    DatabaseService(uid: user.uid);
                databaseService.addProduct(
                  _nameController.text,
                  _descriptionController.text,
                 _priceController.text,
                   _selectedCategory ?? '',
                    imageUrl ?? ''); // Pass imageUrl to addProduct method
                Navigator.pop(context);
              },
              child: const TextCustom(
                  text: ' Save ', color: ColorsFrave.primaryColor))
        ],
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: [
            const SizedBox(height: 10.0),
            const TextCustom(text: 'Product name'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _nameController,
              hintText: 'Product',
              // validator: RequiredValidator(errorText: 'Name is required'),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Product description'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _descriptionController,
              maxLine: 5,
              // validator: RequiredValidator(errorText: 'Description is required'),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Price'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _priceController,
              hintText: '\$ 0.00',
              keyboardType: TextInputType.number,
              // validator: RequiredValidator(errorText: 'Price is required'),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Pictures'),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  final file = File(pickedFile.path);
                  final fileName = basename(file.path);
                  final firebaseStorageRef =
                      FirebaseStorage.instance.ref().child('uploads/$fileName');
                  final uploadTask = firebaseStorageRef.putFile(file);

                  await uploadTask.whenComplete(() async {
                    try {
                      final url = await firebaseStorageRef.getDownloadURL();
                      setState(() {
                        imageUrl = url; // Set the imageUrl state variable
                      });
                    } catch (e) {
                      print('Error uploading image: $e');
                    }
                  });
                }
              },
              child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0)),
                  child: imageUrl != null // Show the selected image if there is one
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            'Tap to select image',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Category'),
            const SizedBox(height: 5.0),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey, blurRadius: 7, spreadRadius: -5.0)
                    ]),
                child: InkWell(
                  onTap: () => _showCategories(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3.5),
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                          const SizedBox(width: 8.0),
                          TextCustom(
                            text: _selectedCategory ?? 'Select a category',
                            color: _selectedCategory == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ],
                      ),
                      const Icon(Icons.navigate_next_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategories(BuildContext context) async {
    final categories = await FirebaseFirestore.instance
        .collection('catagory')
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .map((doc) => {'id': doc.id, 'name': doc.data()['name']})
            .toList());

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a category'),
          content: DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
              Navigator.pop(context);
            },
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category['id'],
                child: Text(category['name']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}