import 'dart:io';
// ignore: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
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

class ProductUpdate extends StatefulWidget {
  String productId;
  ProductUpdate({super.key, required this.productId});

  @override
  // ignore: library_private_types_in_public_api
  _ProductUpdateState createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _amountController;
  late TextEditingController _imageController;
  late String _productId;

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
    _imageController = TextEditingController();
    _productId = widget.productId;
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
    _imageController.clear();
    _imageController.dispose();

    super.dispose();
  }

  Future<void> getPersonalInformation() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final customerRef = FirebaseFirestore.instance
          .collection('products')
          .doc(_productId); //this is product id

      final productSnapshot = await customerRef.get();
      final productData = productSnapshot.data() as Map<String, dynamic>;
      _nameController = TextEditingController(text: productData['name']);
      _descriptionController =
          TextEditingController(text: productData['description']);
      _priceController =
          TextEditingController(text: productData['price'].toString());
      _amountController = TextEditingController(text: productData['amount']);
      _imageController = TextEditingController(text: productData['imageURL']);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 181, 74, 110),
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
    final user = Provider.of<Users>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: ' Update Product'),
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
        ),
        body: FutureBuilder(
            future: getPersonalInformation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else {
                return SafeArea(
                  child: Form(
                    key: _keyForm,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      children: [
                        InkWell(
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (file == null) {
                              return;
                            }
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            // setState(() {
                            //   _imageFile = File(file.path);
                            // });
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
                                  : Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              _imageController.text),
                                        ),
                                      ),
                                    )),
                        ),
                        const SizedBox(height: 30.0),
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
                        const SizedBox(height: 80.0),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_keyForm.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final currentUser =
                                          FirebaseAuth.instance.currentUser;
                                      try {
                                        double price =
                                            double.parse(_priceController.text);
                                        await DatabaseService(
                                                uid: currentUser!.uid)
                                            .updateProductData(
                                                _productId,
                                                _nameController.text,
                                                _descriptionController.text,
                                                price,
                                                _amountController.text);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);

                                        _showSnackbar(
                                            'Product updated successfully');
                                      } catch (error) {
                                        _showSnackbar('Error updating Product');
                                      } finally {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    }
                                  },
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : const TextCustom(
                                    text: 'Update Product',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 230, 103, 6),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              ;
            }));
  }
}
