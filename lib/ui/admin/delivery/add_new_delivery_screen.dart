import 'dart:io';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/admin/components/form_field_frave.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewDeliveryScreen extends StatefulWidget {
  const AddNewDeliveryScreen({super.key});

  @override
  _AddNewDeliveryScreenState createState() => _AddNewDeliveryScreenState();
}

class _AddNewDeliveryScreenState extends State<AddNewDeliveryScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;

  final _keyForm = GlobalKey<FormState>();
/////////////////////

  String imageUrl = '';
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void clearTextEditingController() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
    _addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Add New Delivery'),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(
          child: const TextCustom(
              text: 'Cancel', color: ColorsFrave.primaryColor, fontSize: 17),
          onPressed: () => Navigator.pop(context),
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
                  Reference referenceDirImages = referenceRoot.child('profile');
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                  await referenceImageToUpload.putFile(_imageFile!);
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  AuthService authService = AuthService(uid: user.uid);
                  await authService.registerDelivery(
                    _nameController.text,
                    _phoneController.text,
                    _emailController.text,
                    _passwordController.text,
                    _addressController.text,
                    imageUrl,
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registerd successfully!')));
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: [
            const SizedBox(height: 20.0),
            Align(alignment: Alignment.center, child: pickImage()),
            const SizedBox(height: 20.0),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            const TextCustom(text: 'Name'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              hintText: 'name',
              controller: _nameController,
              // validator: RequiredValidator(errorText: 'Name is required'),
            ),
            const SizedBox(height: 10.0),
            const TextCustom(text: 'Phone'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _phoneController,
              hintText: '---.---.---',
              keyboardType: TextInputType.number,
              // validator: RequiredValidator(errorText: 'Lastname is required'),
            ),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Email'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _emailController,
              hintText: 'email@frave.com',
              keyboardType: TextInputType.emailAddress,
              // validator: validatedEmail
            ),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'address'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _addressController,
              hintText: 'bahir dar',
              // validator: validatedEmail
            ),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Password'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _passwordController,
              hintText: '********',
              isPassword: true,
              // validator: passwordValidator,
            ),
          ],
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
