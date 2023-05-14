import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:delivery/ui/admin/category/add_category_admin_screen.dart';

class CategoriesAdminScreen extends StatelessWidget {
  const CategoriesAdminScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Categories'),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
              TextCustom(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor,)
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
               Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>const AddCategoryAdminScreen(),
                    ),
                  );
            },
            child: const TextCustom(text: 'Add', color: ColorsFrave.primaryColor, fontSize: 17)
          )
        ],
      ),
      body: _ListCategories()
    );
  }
}

class _ListCategories extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('catagory').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center( child:  CircularProgressIndicator());
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: documents.length,
      itemBuilder: (_, i) 
        => Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: ColorsFrave.primaryColor, width: 4.5)
                  ),
                ),
                const SizedBox(width: 20.0),
                TextCustom(text: documents[i].get('name')),
              ],
            ),
          ),
        ),
    );
     } 
      ) 
       );
      }
  }
  
  
