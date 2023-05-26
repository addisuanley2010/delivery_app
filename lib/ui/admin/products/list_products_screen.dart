import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/ui/admin/products/add_new_product_screen.dart';
import 'package:delivery/ui/admin/products/detail_products.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:provider/provider.dart';

class ListProductsScreen extends StatefulWidget {
  const ListProductsScreen({super.key});

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

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
                    builder: (context) => const AddNewProductScreen(),
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
    final user = Provider.of<Users>(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('shopId', isEqualTo: user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...');
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return (documents.isNotEmpty)
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    itemCount: documents.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 450,
                            childAspectRatio: 5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, i) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ProductDetails(
                              productName: documents[i].get('name'),
                              productDescription: documents[i].get('description'),
                              productPrice:  documents[i].get('price'),
                              imageURL:documents[i].get('imageURL'),
                              amount:documents[i].get('amount'),
                              status:documents[i].get('status'),
                              productId:documents[i].id,
                            ),
                          ),
                        );
                      },
                      // onLongPress: () => modalDeleteProduct(context, listProducts[i].nameProduct, listProducts[i].picture, listProducts[i].id.toString()),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  scale: 5,
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextCustom(
                                      text: documents[i].get('name'),
                                      fontSize: 16),
                                  TextCustom(
                                      text: (documents[i].get('amount') != '')
                                          ? 'amount : ${documents[i].get('amount').toString()}'
                                          : '',
                                      fontSize: 16),
                                ],
                              ),
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
