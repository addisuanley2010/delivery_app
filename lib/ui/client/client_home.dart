import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/client/Client_cart_screen.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'component/date_custom.dart';

class ClientHomeScreen extends StatelessWidget {
  List<Catagory> catagory = [
    Catagory(
        id: 1,
        name: 'accessories',
        description: ' computer  phone accessaries'),
    Catagory(id: 2, name: 'computers', description: 'laptops and desktops'),
    Catagory(id: 3, name: 'mobiles', description: 'tablates and smart phones')
  ];

  Future getCatagory() async {
    return await catagory;
  }

  final List<Product> products = [
    Product(
        id: 1,
        description: 'good iphone  mobile',
        picture: "assets/accessery/charger.png",
        nameProduct: ' iphone  ',
        price: 549,
        status: " sold",
        category_id: 3),
    Product(
        id: 2,
        description: 'good iphone  mobile',
        picture: "assets/accessery/charger.png",
        nameProduct: ' memory  ',
        price: 549,
        status: " sold",
        category_id: 1),
    Product(
        id: 3,
        description: 'good iphone  mobile',
        picture: "assets/accessery/charger.png",
        nameProduct: ' airphone  ',
        price: 549,
        status: " sold",
        category_id: 1),
    Product(
        id: 4,
        description: 'good iphone  mobile',
        picture: "assets/accessery/charger.png",
        nameProduct: ' lenevolaptop  ',
        price: 549,
        status: " sold",
        category_id: 2),
    Product(
        id: 5,
        description: 'good iphone  mobile',
        picture: "assets/accessery/charger.png",
        nameProduct: ' hplaptop  ',
        price: 549,
        status: " sold",
        category_id: 2),
  ];

  @override
  Widget build(BuildContext context) {
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
                        text: DateCustom.getDateFrave() +
                            // ', ${authBloc.state.user!.firstName}',
                            " , Aemro client",
                        fontSize: 17,
                        color: ColorsFrave.secundaryColor),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context, routeFrave(page: CartClientScreen())),
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
                              child: const Center(
                                  child:
                                      //BlocBuilder<CartBloc, CartState>(builder: (context, state) =>
                                      TextCustom(
                                          //text: state.quantityCart.toString(),
                                          text: "5",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)))),
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
                          //  text: "(state.addressName != '')  ? state.addressName  : 'without direction'",
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
            FutureBuilder<List<Catagory>>(
              // future: categoryServices.getAllCategories(),
              //future: catagory,
              builder: (context, snapshot) {
                final List<Catagory> category = catagory;

                return !snapshot.hasData
                    ? const ShimmerFrave()
                    : Container(
                        height: 45,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length,
                          itemBuilder: (context, i) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            // onTap: () => Navigator.push(
                            //     context,
                            //     routeFrave(
                            //         page: SearchForCategoryScreen(
                            //             idCategory: category[i].id,
                            //             category: category[i].category))),
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff5469D4).withOpacity(.1),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: TextCustom(text: catagory[0].name),
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
            _ListProducts(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      //future: ClientHomeScreen().products,
      builder: (_, snapshot) {
        final List<Product> listProduct = ClientHomeScreen().products;

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
                itemCount: listProduct.length,
                itemBuilder: (_, i) => Container(
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
                            text: '10 br',
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