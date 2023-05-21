import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/services/database.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/client/component/StaggeredDualView.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:delivery/ui/client/details_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchForCategoryScreen extends StatelessWidget {
  final String categoryId;
  final String category;
  final ClientHomeScreen clientHomeScreen = ClientHomeScreen();

  SearchForCategoryScreen(
      {Key? key, required this.categoryId, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(categoryId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(
            text: category, fontSize: 20, fontWeight: FontWeight.w500),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: StreamBuilder<List<Product>>(
            // future: productServices
            // .searchPorductsForCategory(idCategory.toString()),
            stream: Products().productsListByCatagory(categoryId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) =>
                    (!snapshot.hasData)
                        ? const ShimmerFrave()
                        : ListProducts(listProduct: snapshot.data!)),
      ),
    );
  }
}

class ListProducts extends StatelessWidget {
  final List<Product> listProduct;

  const ListProducts({Key? key, required this.listProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(listProduct);
    return (listProduct.isNotEmpty)
        ? StaggeredDualView(
            spacing: 15,
            alturaElement: 0.14,
            aspectRatio: 0.78,
            itemCount: listProduct.length,
            itemBuilder: (context, i) => Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailsProductScreen(
                                  product: listProduct[i],
                                  quantity: 1,
                                ))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                              tag: listProduct[i].id,
                              // child: Image.network(
                              //     'http://192.168.1.35:7070/' +
                              //         listProduct[i].picture,
                              child: Image.network(listProduct[i].picture,
                                  height: 150)),
                        ),
                        TextCustom(
                            text: listProduct[i].name,
                            textOverflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: ColorsFrave.primaryColor,
                            fontSize: 19),
                        const SizedBox(height: 5.0),
                        TextCustom(
                            text: '\$ ${listProduct[i].price.toString()}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                ))
        : _withoutProducts();
  }

  Widget _withoutProducts() {
    return Column(
      children: [
        SvgPicture.asset('assets/svg/empty-cart.svg', height: 450),
        const TextCustom(
            text: 'Without products',
            fontSize: 21,
            color: ColorsFrave.primaryColor)
      ],
    );
  }
}
