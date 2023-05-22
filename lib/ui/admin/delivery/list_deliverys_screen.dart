import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/admin/delivery/add_new_delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';

class ListDeliverysScreen extends StatefulWidget {
  @override
  State<ListDeliverysScreen> createState() => _ListDeliverysScreenState();
}

class _ListDeliverysScreenState extends State<ListDeliverysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'List Delivery men'),
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
                text: 'Back',
                fontSize: 17,
                color: ColorsFrave.primaryColor,
              )
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewDeliveryScreen(),
                  ),
                );
              },
              child: const TextCustom(
                  text: 'Add', color: ColorsFrave.primaryColor, fontSize: 17))
        ],
      ),
      body:_ListDelivery()

    );
  }
}

class _ListDelivery extends StatelessWidget {


  @override
    Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('customers').where('role', isEqualTo:'delivery').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center( child:  CircularProgressIndicator());
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
         return (documents.length != 0)
        ? ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            itemCount: documents.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(documents[i].get('imageUrl'))),
                    ),
                    
                  ) ,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                            text: documents[i].get('name'),
                            fontWeight: FontWeight.w500),
                        const SizedBox(height: 5.0),
                        TextCustom(
                            text: documents[i].get('phone'), color: Colors.grey),
                      ],
                    )
                   ],
                ),
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/empty-cart.svg', height: 290),
                const SizedBox(height: 20.0),
                const TextCustom(
                    text: 'Without Delivery men',
                    color: ColorsFrave.primaryColor,
                    fontSize: 20)
              ],
            ),
          );
      } 
     )
      );
          
  }
      
}
