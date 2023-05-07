import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/admin/components/form_field_frave.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;
  bool showPassword = true;
  bool showPassword1 = true;
  bool showPassword2 = true;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void clearTextEditingController() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _repeatPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustom(text: 'Change Password'),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const TextCustom(
                text: 'Cancel', fontSize: 17, color: ColorsFrave.primaryColor)),
        actions: [
          TextButton(
              onPressed: () {
                // if( _keyForm.currentState!.validate()){
                //   userBloc.add( OnChangePasswordEvent(_currentPasswordController.text, _newPasswordController.text) );
                // }
              },
              child: const TextCustom(
                  text: 'Save', fontSize: 16, color: ColorsFrave.primaryColor))
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _keyForm,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Current Password'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _currentPasswordController,
                  isPassword: showPassword,
                  suffixIcon: IconButton(
                      splashRadius: 20,
                     icon:!showPassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                      onPressed: () {
                        setState(() {
                           showPassword = !showPassword;
                        });
                      }),
                  // validator: passwordValidator,
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'New Password'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _newPasswordController,
                  isPassword: showPassword1,
                  suffixIcon: IconButton(
                      splashRadius: 20,
                     icon:!showPassword1 ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                      onPressed: () {
                        setState(() {
                           showPassword1 = !showPassword1;
                        });
                      }),
                  // validator: passwordValidator,
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Repeat Password'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _repeatPasswordController,
                  isPassword: showPassword2,
                  suffixIcon: IconButton(
                      splashRadius: 20,
                     icon:!showPassword2 ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                      onPressed: () {
                        setState(() {
                           showPassword2 = !showPassword2;
                        });
                      }),
                  validator: (val) {
                    if (val != _newPasswordController.text) {
                      return 'Passwords do not match';
                    } else {
                      return 'Repeat password is required';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class FormFieldFravePassword extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final bool isPassword;
//   final TextInputType keyboardType;
//   final int maxLine;
//   final bool readOnly;
//   final Widget? suffixIcon;
//   final FormFieldValidator<String>? validator;

//   const FormFieldFravePassword(
//       {this.controller,
//       this.hintText,
//       this.isPassword = false,
//       this.keyboardType = TextInputType.text,
//       this.maxLine = 1,
//       this.readOnly = false,
//       this.suffixIcon,
//       this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       style: GoogleFonts.getFont('Roboto', fontSize: 18),
//       obscureText: isPassword,
//       maxLines: maxLine,
//       readOnly: readOnly,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//           enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(width: .5, color: Colors.grey)),
//           contentPadding: const EdgeInsets.only(left: 15.0),
//           hintText: hintText,
//           hintStyle: GoogleFonts.getFont('Roboto', color: Colors.grey),
//           suffixIcon: suffixIcon),
//       validator: validator,
//     );
//   }
// }
