import 'dart:async';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/ui/client/component/modal_success.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsProductScreen extends StatefulWidget {
  final Product product;
  int quantity;
  DetailsProductScreen(
      {super.key, required this.product, required this.quantity});

  @override
  _DetailsProductScreenState createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final cartBloc = BlocProvider.of<CartBloc>(context);
    final cartController = Provider.of<CartController>(context);
    CartItem cartItem = CartItem(
        productId: widget.product.id,
        name: widget.product.name,
        price: widget.product.price,
        imageUrl: widget.product.picture,
        quantity: widget.quantity,
        shopId: widget.product.shopeId);

    //print('current detail product = ${widget.product.id}');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (isLoading)
                ? Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 360,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0))),
                            child: Hero(
                              tag: widget.product.id,
                              child: Container(
                                height: 180,
                                // child: CarouselSlider.builder(
                                //   itemCount: imagesProducts.length,
                                //   options: CarouselOptions(
                                //       viewportFraction: 1.0, autoPlay: true),
                                //   itemBuilder: (context, i, realIndex) =>
                                //       Container(
                                //     width: size.width,
                                //     child:
                                //         Image.asset(widget.product.picture),
                                child: Image.asset(
                                  'assets/phone/iphone.png',

                                  // child: Image.network(
                                  //   widget.product.picture,

                                  // child: Asset.network(
                                  //     widget.product.picture),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.pop(context);
                                // cartBloc.add(OnResetQuantityEvent());
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.black),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ),
                            const TextCustom(
                                text: 'Details',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: const Icon(Icons.favorite_border_outlined,
                                  size: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : const ShimmerFrave(),

            ///////////////////
            ///////////////////////////
            ///////////////////////////
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: ColorsFrave.primaryColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: const [
                        Icon(Icons.star_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 3.0),
                        TextCustom(
                            text: '4.9', color: Colors.white, fontSize: 17)
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.timer, size: 18),
                      SizedBox(width: 5.0),
                      TextCustom(text: '30 Min'),
                    ],
                  ),
                  const TextCustom(text: '\$ Free Shipping')
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextCustom(
                  text: widget.product.name,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextCustom(
                  text: widget.product.description,
                  fontSize: 18,
                  color: Colors.grey,
                  maxLine: 5),
            ),
            const SizedBox(height: 20.0),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.0)),

                          //                           Consumer<CartController>(
                          // builder: (context, cartController, child) {

                          child: Consumer<CartController>(
                            builder: (context, cartController, child)
                                // builder: (context, state)
                                {
                              int index = cartController.items.indexWhere(
                                  (item) =>
                                      item.productId == widget.product.id);

                              if (index >= 0) {
                                cartItem = cartController.items.firstWhere(
                                    (item) =>
                                        item.productId == widget.product.id);
                              }

                              ///
                              //print("index at stream =${index}");
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        if (widget.product.status ==
                                            'not sold') {
                                          setState(() {
                                            if (index >= 0) {
                                              cartController.decreaseQuantity(
                                                  cartItem.productId);
                                            } else {
                                              cartController.addItem(
                                                  cartItem.productId,
                                                  cartItem.name,
                                                  cartItem.price,
                                                  cartItem.imageUrl,
                                                  cartItem.shopId);
                                              if (cartItem.quantity > 1) {
                                                cartController.decreaseQuantity(
                                                    cartItem.productId);
                                              }
                                            }
                                          });
                                        }
                                        // increaseQuantity
                                        // CartController().decreaseQuantity(
                                        //     cartItem.productId);

                                        // if (state.quantity > 1)
                                        //   cartBloc.add(
                                        //       OnDecreaseProductQuantityEvent());
                                      }),
                                  const SizedBox(width: 7.0),
                                  TextCustom(
                                      text: (index >= 0)
                                          ? cartController.items[index].quantity
                                              .toString()
                                          : cartItem.quantity.toString(),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(width: 7.0),
                                  IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor:
                                          Color.fromARGB(0, 184, 123, 123),
                                      icon: const Icon(Icons.add),
                                      onPressed: () async {
                                        if (widget.product.status ==
                                            'not sold') {
                                          // setState(()  {    // it may have some functionality i comment it unconditionaly
                                          if (index >= 0) {
                                            dynamic result =
                                                await cartController
                                                    .increaseQuantity(
                                                        cartItem.productId);
                                            // print('${result}');
                                            // if (result == true) {
                                            //   print('increase quantity called');
                                            // } else {
                                            //   // ignore: use_build_context_synchronously
                                            //   modalSuccess(
                                            //       context,
                                            //       'can not add above this quantity',
                                            //       () => Navigator.pop(context));
                                            // }
                                          } else {
                                            cartController.addItem(
                                                cartItem.productId,
                                                cartItem.name,
                                                cartItem.price,
                                                cartItem.imageUrl,
                                                cartItem.shopId);
                                            dynamic result =
                                                await cartController
                                                    .increaseQuantity(
                                                        cartItem.productId);
                                            print('${result}');
                                            if (result == true) {
                                              print('increase quantity called');
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              modalSuccess(
                                                  context,
                                                  'can not add above this quantity',
                                                  () => Navigator.pop(context));
                                            }
                                          }
                                          // });   //end of set state
                                        }
                                        //cartBloc.add(OnIncreaseProductQuantityEvent())

                                        // CartController()
                                        //     .increaseQuantity(cartItem.productId)
                                        // cartItem.quantity++

                                        // onPressed: () =>
                                        //String id, String name, double price
                                        // Cart().addItem(widget.product.id,widget.product.name,widget.product.price);
                                      }),
                                ],
                              );
                            }, //row here
                          ),
                        ),
                        (widget.product.status == 'not sold')
                            ? Container(
                                height: 50,
                                width: 220,
                                decoration: BoxDecoration(
                                    color: ColorsFrave.primaryColor,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      child: const TextCustom(
                                          text: 'Add to cart',
                                          color: Colors.white,
                                          fontSize: 18),
                                      onPressed: () {
                                        cartController.addItem(
                                            cartItem.productId,
                                            cartItem.name,
                                            cartItem.price,
                                            cartItem.imageUrl,
                                            cartItem.shopId);
                                        // final newProduct = ProductCart(
                                        //     uidProduct:
                                        //         widget.product.id.toString(),
                                        //     imageProduct:
                                        //         widget.product.picture,
                                        //     nameProduct:
                                        //         widget.product.nameProduct,
                                        //     price: widget.product.price,
                                        //     quantity: cartBloc.state.quantity);
                                        // cartBloc.add(OnAddProductToCartEvent(
                                        //     newProduct));

                                        modalSuccess(context, 'Product Added',
                                            () => Navigator.pop(context));
                                        // print(cartController.items);
                                      },
                                    ),
                                    const SizedBox(width: 5.0),

                                    // BlocBuilder<CartBloc, CartState>(
                                    // builder: (context, state) =>
                                    //snapshot.data!.quantity
                                    TextCustom(
                                        text:
                                            (cartItem.quantity * cartItem.price)
                                                .toString(),
                                        // '\$ ${widget.product.price * state.quantity}',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20)
                                    //)
                                  ],
                                ))
                            : Container(
                                height: 50,
                                width: 220,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.sentiment_dissatisfied_rounded,
                                        color: Colors.white, size: 30),
                                    SizedBox(width: 5.0),
                                    TextCustom(
                                        text: 'SOLD OUT',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
