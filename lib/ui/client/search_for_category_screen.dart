import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/client/component/StaggeredDualView.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchForCategoryScreen extends StatelessWidget {
  final int categoryId;
  final String category;
  final ClientHomeScreen clientHomeScreen = ClientHomeScreen();

  SearchForCategoryScreen(
      {Key? key, required this.categoryId, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(
            text: category, fontSize: 20, fontWeight: FontWeight.w500),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: FutureBuilder<List<Product>>(
            // future: productServices
            // .searchPorductsForCategory(idCategory.toString()),
            future: clientHomeScreen.getProductByCatagory(categoryId),
            builder: (context, snapshot) => (!snapshot.hasData)
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
    return (listProduct.length != 0)
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
                    // onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) =>
                    //             DetailsProductScreen(product: listProduct[i]))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                              tag: listProduct[i].id,
                              // child: Image.network(
                              //     'http://192.168.1.35:7070/' +
                              //         listProduct[i].picture,
                              child: Image.asset(listProduct[i].picture,
                                  height: 150)),
                        ),
                        TextCustom(
                            text: listProduct[i].nameProduct,
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
        SvgPicture.asset('Assets/empty-cart.svg', height: 450),
        const TextCustom(
            text: 'Without products',
            fontSize: 21,
            color: ColorsFrave.primaryColor)
      ],
    );
  }
}
