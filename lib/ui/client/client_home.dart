import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/models/location_model.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/database.dart';
import 'package:delivery/services/locationService.dart';
import 'package:delivery/ui/client/Client_cart_screen.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/bottom_navigation_frave.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:delivery/ui/client/details_product_screen.dart';
import 'package:delivery/ui/client/search_for_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'component/date_custom.dart';

class ClientHomeScreen extends StatelessWidget {
  ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //print('cient home');
    final user = Provider.of<Users?>(context);
    //final cartController = Provider.of<CartController>(context);
    final addressController = Provider.of<AddressController>(context);

    Mylocation location;

    getLocation().then((data) {
      location = data;
      // print('latitude:  ${location.lat}');
      //print('longtude:  ${location.long}');
    });
    print('address new = ${addressController.address.name}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            //  '${Environment.endpointBase}${authBloc.state.user!.image}'))),
                            image: AssetImage('assets/images/bg.png'),
                          )),
                    ),
                    const SizedBox(width: 8.0),
                    TextCustom(
                        text: "${DateCustom.getDateFrave()} , Aemro client",
                        fontSize: 17,
                        color: ColorsFrave.secundaryColor),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context, routeFrave(page: const CartClientScreen())),
                  child: Stack(
                    children: [
                      const Icon(Icons.shopping_bag_outlined, size: 30),
                      Positioned(
                          right: 0,
                          bottom: 5,
                          child: Container(
                              height: 20,
                              width: 15,
                              decoration: const BoxDecoration(
                                  color: Color(0xff0C6CF2),
                                  shape: BoxShape.circle),
                              child: Center(
                                  child:
                                      //BlocBuilder<CartBloc, CartState>(builder: (context, state) =>
                                      Consumer<CartController>(
                                          builder: (context, cartController,
                                                  child) =>
                                              TextCustom(
                                                  //text: state.quantityCart.toString(),
                                                  text:
                                                      '${cartController.items.length} Items',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))))),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            const Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: TextCustom(
                    text: 'What do you want buy today?',
                    fontSize: 28,
                    maxLine: 2,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: const Icon(Icons.place_outlined,
                      size: 38, color: Colors.grey),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(text: 'Address'),
                    InkWell(
                        onTap: () => {},
                        child:
                            // BlocBuilder<UserBloc, UserState>( builder: (context, state) =>
                            const TextCustom(
                          //  text: "(state.addressName != '') f ? state.addressName  : 'without direction'",
                          text: "Addis Abeba",
                          color: ColorsFrave.primaryColor,
                          fontSize: 17,
                          maxLine: 1,
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20.0),
            StreamBuilder<List<Catagory>>(
              stream: Category().catagory1,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Catagory>> snapshot) {
                final List<Catagory>? category = snapshot.data;
                // print(category);

                return !snapshot.hasData
                    ? const ShimmerFrave()
                    : Container(
                        height: 45,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, i) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                                context,
                                routeFrave(
                                    page: SearchForCategoryScreen(
                                        categoryId: category[i].id,
                                        category: category[i].name))),
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff5469D4).withOpacity(.1),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: TextCustom(text: category![i].name),
                              //child: Text('catagory'),
                            ),
                          ),
                        ),
                      );
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TextCustom(
                    text: 'Populer Items',
                    fontSize: 21,
                    fontWeight: FontWeight.w500),
                TextCustom(
                    text: 'See All',
                    color: ColorsFrave.primaryColor,
                    fontSize: 17)
              ],
            ),
            const SizedBox(height: 20.0),
            _ListProducts(addressId: addressController.address.id),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationFrave(0),
    );
  }
}

class _ListProducts extends StatelessWidget {
  final String addressId;
  const _ListProducts({required this.addressId});

  @override
  Widget build(BuildContext context) {
   // print('product list called');

    return StreamBuilder<List<Product>>(
      stream: Products(addressId: addressId).productsList,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        final List<Product>? listProduct = snapshot.data;
        //print(listProduct);
        // print(snapshot.data![0].picture);
        return !snapshot.hasData
            ? Column(
                children: const [
                  ShimmerFrave(),
                  SizedBox(height: 10.0),
                  ShimmerFrave(),
                  SizedBox(height: 10.0),
                  ShimmerFrave(),
                ],
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 220),
                itemCount: listProduct!.length,
                itemBuilder: (_, i) => Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailsProductScreen(
                                product: listProduct[i], quantity: 1))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                              tag: listProduct[i].id,
                              //  child: Image.network(listProduct[i].picture,
                              child: Image.asset('assets/phone/iphone.png',
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
                            text: listProduct[i].price.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                ), //here
              );
      },
    );
  }
}
