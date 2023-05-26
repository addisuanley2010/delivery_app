import 'dart:io';
// ignore: depend_on_referenced_packages

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
  late TextEditingController _amountController;

  final _keyForm = GlobalKey<FormState>();

  String imageUrl = '';
  File? _imageFile;
  bool _isLoading = false;
  String? _selectedCategory;
  String? _selectedName;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.clear();
    _nameController.dispose();
    _descriptionController.clear();
    _descriptionController.dispose();
    _priceController.clear();
    _priceController.dispose();
    _amountController.clear();
    _amountController.dispose();
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
          },
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                if (_imageFile == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an image')));
                  return;
                }
                setState(() {
                  _isLoading = true;
                });
                try {
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                  await referenceImageToUpload.putFile(_imageFile!);

                  imageUrl = await referenceImageToUpload.getDownloadURL();

                  DatabaseService databaseService =
                      DatabaseService(uid: user.uid);
                  double doubleValue = double.parse(_priceController.text);
                  int intAmount = int.parse(_amountController.text);

                  await databaseService.addProduct(
                      _nameController.text,
                      _descriptionController.text,
                      doubleValue,
                      intAmount,
                      _selectedCategory ?? '',
                      imageUrl);

                  setState(() {
                    _isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item added successfully')));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Error: $error')));
                }
              },
              child: const TextCustom(
                  text: ' Save ', color: ColorsFrave.primaryColor))
        ],
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
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
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            const TextCustom(text: 'Price'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _priceController,
              hintText: ' 0.00 birr',
              keyboardType: TextInputType.number,
              // validator: RequiredValidator(errorText: 'Price is required'),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Amount'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _amountController,
              hintText: '10',
              keyboardType: TextInputType.number,
              // validator: RequiredValidator(errorText: 'Price is required'),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Pictures'),
            const SizedBox(height: 10.0),
            InkWell(
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
                // child: InkWell(
                //   onTap: () => _showCategories(context),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           Container(
                //             height: 20,
                //             width: 20,
                //             decoration: BoxDecoration(
                //                 border:
                //                     Border.all(color: Colors.blue, width: 3.5),
                //                 borderRadius: BorderRadius.circular(6.0)),
                //           ),
                //           const SizedBox(width: 8.0),
                //           TextCustom(
                //             text: _selectedCategory ?? 'Select a category',
                //             color: _selectedCategory == null
                //                 ? Colors.grey
                //                 : Colors.black,
                //           ),
                //         ],
                //       ),
                //       const Icon(Icons.navigate_next_rounded)
                //     ],
                //   ),
                // ),

                child: InkWell(
                  onTap: () async {
                    final categories = await FirebaseFirestore.instance
                        .collection('catagory')
                        .get()
                        .then((querySnapshot) => querySnapshot.docs
                            .map((doc) =>
                                {'id': doc.id, 'name': doc.data()['name']})
                            .toList());
                    // ignore: use_build_context_synchronously
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final category = categories[index];
                            print(category['id']);
                            return ListTile(
                              title: Text(category['name']),
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category['id'];
                                  _selectedName = category['name'];
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      children: [
                        const Icon(Icons.category),
                        const SizedBox(width: 25.0),
                        Expanded(
                          child: Text(
                            _selectedCategory == null
                                ? 'Select a category'
                                : 'Category: $_selectedName',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
