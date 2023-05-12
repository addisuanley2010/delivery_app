import 'package:delivery/models/user.dart';
import 'package:delivery/services/database.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/admin/components/form_field_frave.dart';
import 'package:provider/provider.dart';

class AddCategoryAdminScreen extends StatefulWidget {
  const AddCategoryAdminScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddCategoryAdminScreenState createState() => _AddCategoryAdminScreenState();
}

class _AddCategoryAdminScreenState extends State<AddCategoryAdminScreen> {
  late TextEditingController _nameCategoryController;
  late TextEditingController _categoryDescriptionController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameCategoryController = TextEditingController();
    _categoryDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameCategoryController.clear();
    _categoryDescriptionController.clear();
    _nameCategoryController.dispose();
    _categoryDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final productBloc = BlocProvider.of<ProductsBloc>(context);
    final user = Provider.of<Users>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Add Category'),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColor, size: 17),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor)
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                
                // if( _keyForm.currentState!.validate() ){


                 DatabaseService databaseService =
                    DatabaseService(uid: user.uid);
                databaseService.addNewCatagory(
                    _nameCategoryController.text, _categoryDescriptionController.text);

                // }

              },
              child: const TextCustom(
                  text: 'Save', color: ColorsFrave.primaryColor))
        ],
      ),
      body: Form(
        key: _keyForm,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              const TextCustom(text: 'Category name'),
              const SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _nameCategoryController,
                hintText: 'Drinks',
                // validator: RequiredValidator(errorText: 'Category name is required'),
              ),
              const SizedBox(height: 25.0),
              const TextCustom(text: 'Category Description'),
              const SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _categoryDescriptionController,
                maxLine: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
