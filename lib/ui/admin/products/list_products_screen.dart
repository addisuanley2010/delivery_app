import 'package:delivery/ui/admin/products/add_new_product_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:restaurant/data/env/environment.dart';
// import 'package:restaurant/domain/bloc/blocs.dart';
// import 'package:restaurant/domain/models/response/products_top_home_response.dart';
// import 'package:restaurant/domain/services/products_services.dart';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';

class ListProductsScreen extends StatefulWidget {

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
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
                TextCustom(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor)
              ],
            ),
          ),
          actions: [
            TextButton(
              // onPressed: () => Navigator.push(context, routeFrave(page: AddNewProductScreen())), 
               onPressed: () {
               Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewProductScreen(),
                    ),
                  );
            },
              child: const TextCustom(text: 'Add', fontSize: 17, color: ColorsFrave.primaryColor)
            )
          ],
        ),
        body: _GridViewListProduct(),
        // body: FutureBuilder(
        //   future: productServices.listProductsAdmin(),
        //   builder: (context, snapshot) 
        //     => ( !snapshot.hasData )
        //       ? const ShimmerFrave()
        //       : _GridViewListProduct(listProducts: snapshot.data!)
           
        // ),
    );
  }
}

class _GridViewListProduct extends StatelessWidget {
  
  // final List listProducts;

  // const _GridViewListProduct({required this.listProducts});

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      // itemCount: listProducts.length,
            itemCount: 10,

      gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ), 
      itemBuilder: (context, i) 
        => InkWell(
          // onTap: () => modalActiveOrInactiveProduct(context, listProducts[i].status, listProducts[i].nameProduct, listProducts[i].id, listProducts[i].picture),
          // onLongPress: () => modalDeleteProduct(context, listProducts[i].nameProduct, listProducts[i].picture, listProducts[i].id.toString()),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    scale: 7,
                    image: NetworkImage('https://images.unsplash.com/photo-1572888195250-3037a59d3578?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZXRoaW9waWF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60')
                  )
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    // color: ( listProducts[i].status == 1 ) ? Colors.grey[50] : Colors.red[100]
                  ),
                  // child: TextCustom(text: listProducts[i].nameProduct, fontSize: 16),
                    child: TextCustom(text: "mobile", fontSize: 16),


                ),
              ),
            ],
          ),
        ),
    );  

  }



}