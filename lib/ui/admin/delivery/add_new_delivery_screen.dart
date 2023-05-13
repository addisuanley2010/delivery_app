import 'dart:io';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/services/database.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/admin/components/form_field_frave.dart';
import 'package:provider/provider.dart';

class AddNewDeliveryScreen extends StatefulWidget {
  @override
  _AddNewDeliveryScreenState createState() => _AddNewDeliveryScreenState();
}

class _AddNewDeliveryScreenState extends State<AddNewDeliveryScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearTextEditingController() {
    _nameController.clear();
    _lastnameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
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
                // if( _keyForm.currentState!.validate() ){
                //   userBloc.add( OnRegisterDeliveryEvent(

                //     userBloc.state.pictureProfilePath
                //   ));

                // }

                AuthService authService = AuthService(uid: user.uid);
                await authService.registerDelivery(
                  _nameController.text,
                  _lastnameController.text,
                  _phoneController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                // ignore: use_build_context_synchronously
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
            const SizedBox(height: 20.0),
            Align(alignment: Alignment.center, child: _PictureRegistre()),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Name'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              hintText: 'name',
              controller: _nameController,
              // validator: RequiredValidator(errorText: 'Name is required'),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Lastname'),
            const SizedBox(height: 5.0),
            FormFieldFrave(
              controller: _lastnameController,
              hintText: 'lastname',
              // validator: RequiredValidator(errorText: 'Lastname is required'),
            ),
            const SizedBox(height: 20.0),
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
}

class _PictureRegistre extends StatelessWidget {
  // final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey[300]!),
          shape: BoxShape.circle),
      child: const Text("This is image picker widget i will do later"),
    );
  }
}
