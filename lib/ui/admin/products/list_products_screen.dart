import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/admin/products/add_new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';

class ListProductsScreen extends StatefulWidget {
  const ListProductsScreen({super.key});

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'List Products', fontSize: 19),
        centerTitle: true,
        leadingWidth: 80,
        elevation: 0,
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
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewProductScreen(),
                  ),
                );
              },
              child: const TextCustom(
                  text: 'Add', fontSize: 17, color: ColorsFrave.primaryColor))
        ],
      ),
      body: _GridViewListProduct(),
    );
  }
}

class _GridViewListProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...');
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return (documents.length != 0)
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    itemCount: documents.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, i) => InkWell(
                      // onTap: () => modalActiveOrInactiveProduct(context, listProducts[i].status, listProducts[i].nameProduct, listProducts[i].id, listProducts[i].picture),
                      // onLongPress: () => modalDeleteProduct(context, listProducts[i].nameProduct, listProducts[i].picture, listProducts[i].id.toString()),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  scale: 7,
                                  image: NetworkImage(
                                      documents[i].get('imageURL')),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.grey[50],
                                // color: ( documents[i].status == 1 ) ? Colors.grey[50] : Colors.red[100]
                              ),
                              child: TextCustom(
                                  text: documents[i].get('name'), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/svg/empty.png', height: 290),
                        const SizedBox(height: 20.0),
                        const TextCustom(
                            text: 'No Products Found !',
                            color: ColorsFrave.primaryColor,
                            fontSize: 20)
                      ],
                    ),
                  );
          }),
    );
  }
}
