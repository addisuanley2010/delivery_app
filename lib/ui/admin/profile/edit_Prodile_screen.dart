import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import '../components/form_field_frave.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  final _keyForm = GlobalKey<FormState>();

  Future<void> getPersonalInformation() async {
    _nameController = TextEditingController(text: "Addisu");
    _lastNameController = TextEditingController(text: "Anley");
    _phoneController = TextEditingController(text: "0912321213");
    _emailController = TextEditingController(text: "addisu@gmail.com");
  }

  @override
  void initState() {
    super.initState();
    getPersonalInformation();
  }

  @override
  void dispose() {
    _nameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _emailController.clear();
    super.dispose();
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
              onPressed: () {
                if (_keyForm.currentState!.validate()) {}
              },
              child: TextCustom(
                  text: 'Update account',
                  fontSize: 16,
                  color: Colors.amber[900]!))
        ],
      ),
      body: SafeArea(
        child: Form(
            key: _keyForm,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              children: [
                const TextCustom(
                    text: 'Name', color: ColorsFrave.secundaryColor),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _nameController,
                  // validator: RequiredValidator(errorText: 'Name is required')
                ),
                const SizedBox(height: 20.0),
                const TextCustom(
                    text: 'Lastname', color: ColorsFrave.secundaryColor),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _lastNameController,
                  hintText: 'lastname',
                  // validator: RequiredValidator(errorText: 'Lastname is required'),
                ),
                const SizedBox(height: 20.0),
                const TextCustom(
                    text: 'Phone', color: ColorsFrave.secundaryColor),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  hintText: '000-000-000',
                  // validator: validatedPhoneForm,
                ),
                const SizedBox(height: 20.0),
                const TextCustom(
                    text: 'Email Address', color: ColorsFrave.secundaryColor),
                const SizedBox(height: 5.0),
                FormFieldFrave(controller: _emailController, readOnly: true),
                const SizedBox(height: 20.0),
              ],
            )),
      ),
    );
  }
}
