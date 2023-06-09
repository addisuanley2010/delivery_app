import 'package:chapasdk/chapasdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/auth.dart';
import 'package:delivery/ui/client/check_out_screen.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/btn_frave.dart';
import 'package:delivery/ui/client/component/modal_error.dart';
import 'package:delivery/ui/client/component/modal_success.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//{ "amount":"1000",
// "currency": "ETB",
// "email": "aemro@gmail.com",
// "first_name": "aemro",
// "last_name": "enyew",
// "phone_number": "0930375845",
// "tx_ref": "chewatatest-1992",
// "callback_url": "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
// "return_url": "https://www.google.com/",
// "customization[title]": "Payment ",
// "customization[description]": "I love online payments."
// }
//token== secrete key

class CartClientScreen extends StatefulWidget {
  const CartClientScreen({super.key});

  @override
  State<CartClientScreen> createState() => _CartClientScreenState();
}

class _CartClientScreenState extends State<CartClientScreen> {
  @override
  final AuthService _auth = AuthService();
  String name = 'getch';
  String email = 'getch@gmail.com';
  //String imageUrl = '';
  String status = 'approved';
  String phone = '0930375845';

  void getcustomer() {
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    final customerRef =
        FirebaseFirestore.instance.collection('customers').doc(currentUser.uid);

    customerRef.snapshots().map((customerSnapshot) {
      final customerData = customerSnapshot.data() as Map<String, dynamic>;
      name = customerData['name'];
      email = customerData['email'];
      print(name);
      print(email);
      // imageUrl = customerData['imageUrl'];
      phone = customerData['phone'];
    });
  }

  Widget build(BuildContext context) {
    //final cartBloc = BlocProvider.of<CartBloc>(context);
    // final cartController = Provider.of<CartController>(context);
    final user = Provider.of<Users>(context);

    print('chapa done at this here and there');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextCustom(
            text: 'My Bag', fontSize: 20, fontWeight: FontWeight.w500),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColor, size: 19),
              TextCustom(
                  text: 'Back', fontSize: 16, color: ColorsFrave.primaryColor)
            ],
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context, routeFrave(page: ClientHomeScreen()), (route) => false),
        ),
        actions: [
          Center(child:
              //BlocBuilder<CartBloc, CartState>(
              //   builder: (context, cartController)
              //     =>
              Consumer<CartController>(
                  builder: (context, cartController, child) {
            return TextCustom(
                text: '${cartController.items.length} Items', fontSize: 17);
          })),
          const SizedBox(width: 10.0)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<CartController>(
                  builder: (context, cartController, child) =>
                      //   BlocBuilder<CartBloc, CartState>(
                      //       builder: (context, cartController) => (cartController.quantityCart != 0)
                      //(cartController.items.length>0)?
                      // cartController.items
                      (cartController.items.isNotEmpty)
                          // ? const TextCustom(text: 'my cart lists')
                          ? ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              itemCount: cartController.items.length,
                              itemBuilder: (_, i) => Dismissible(
                                    key: Key(cartController.items[i].productId),
                                    direction: DismissDirection.endToStart,
                                    background: Container(),
                                    secondaryBackground: Container(
                                      padding:
                                          const EdgeInsets.only(right: 35.0),
                                      margin:
                                          const EdgeInsets.only(bottom: 15.0),
                                      alignment: Alignment.centerRight,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0))),
                                      child: const Icon(
                                          Icons.delete_sweep_rounded,
                                          color: Colors.white,
                                          size: 40),
                                    ),
                                    onDismissed: (direccion) =>
                                        cartController.removeItem(
                                            cartController.items[i].productId)
                                    //     cartBloc.add(OnDeleteProductToCartEvent(i))
                                    ,
                                    child: Container(
                                        //holds list of(rows of) cart item added
                                        //  height: 90,  buttom overflowed by 7.0 pixel,
                                        height: 120,
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(bottom: 15.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Row(
                                          //this is single row(data of single item) , this is repeated(loop) by listView
                                          children: [
                                            Container(
                                              width: 100,
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      scale: 8,

                                                      //  child: Image.asset(listProduct[i].picture,
                                                      image: AssetImage(
                                                        'assets/phone/iphone.png',

                                                        // image: NetworkImage(
                                                        //   cartController
                                                        //       .items[i].imageUrl,
                                                      ))),
                                            ),
                                            Container(
                                              width: 130,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextCustom(
                                                      text: cartController
                                                          .items[i].name,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20),
                                                  const SizedBox(height: 10.0),
                                                  TextCustom(
                                                      text:
                                                          '\$ ${cartController.items[i].price * cartController.items[i].quantity}',
                                                      color: ColorsFrave
                                                          .primaryColor)
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        alignment: Alignment
                                                            .center,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: ColorsFrave
                                                                    .primaryColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: InkWell(
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white),
                                                          onTap: () {
                                                            cartController
                                                                .decreaseQuantity(
                                                                    cartController
                                                                        .items[
                                                                            i]
                                                                        .productId);
                                                            // if (cartController.products![i]
                                                            //         .quantity >
                                                            //     1)
                                                            //   cartBloc.add(
                                                            //       OnDecreaseProductQuantityToCartEvent(
                                                            //           i));
                                                          },
                                                        )),
                                                    const SizedBox(width: 10.0),
                                                    TextCustom(
                                                        text:
                                                            '${cartController.items[i].quantity}',
                                                        color: ColorsFrave
                                                            .primaryColor),
                                                    const SizedBox(width: 10.0),
                                                    Container(
                                                        alignment: Alignment
                                                            .center,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: ColorsFrave
                                                                    .primaryColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: InkWell(
                                                            child: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white),
                                                            onTap: () async {
                                                              //you can not add above this quantity , unavaillabe
                                                              dynamic result = await cartController
                                                                  .increaseQuantity(
                                                                      cartController
                                                                          .items[
                                                                              i]
                                                                          .productId);

                                                              // print(
                                                              //     '${result}');
                                                              // if (result ==
                                                              //     true) {
                                                              //   print(
                                                              //       'increase quantity called');
                                                              // } else {
                                                              //   // ignore: use_build_context_synchronously
                                                              //   modalSuccess(
                                                              //       context,
                                                              //       'can not add above this',
                                                              //       () => Navigator
                                                              //           .pop(
                                                              //               context));
                                                              // }

                                                              // cartBloc.add(
                                                              //   OnIncreaseQuantityProductToCartEvent(
                                                              //       i))
                                                            }))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ))
                          : _WithOutProducts()

                  ///// consumer bracket below

                  ),
            ),
            Container(
              height: 200,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10.0)),
                //child:
                // BlocBuilder<CartBloc, CartState>(
                //   builder: (context, cartController) =>

                child: Consumer<CartController>(
                  builder: (context, cartController, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustom(text: 'Total'),
                          TextCustom(text: '${cartController.totalAmount}'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustom(text: 'Sub Total'),
                          TextCustom(text: '${cartController.totalAmount}'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      BtnFrave(
                        text: 'Checkout',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: (cartController.items.isNotEmpty)
                            ? ColorsFrave.primaryColor
                            : ColorsFrave.secundaryColor,
                        onPressed: () async {
                          // try {
                          dynamic result =
                              await cartController.checkout(user.uid);
                          if (result == true) {
                            print('my bag screen : cart added successfully');
                            // ignore: use_build_context_synchronously
                            modalSuccess(context, 'checked',
                                () => Navigator.pop(context));
                            // //order
                            // if (cartController.items.isNotEmpty) {
                            //   dynamic result =
                            //       await cartController.placeOrder(user.uid);
                            //   // print('${result}');
                            //   if (result == true) {
                            //     print(
                            //         'my bag screen : cart added successfully');
                            //     // ignore: use_build_context_synchronously
                            //     modalSuccess(context, 'your  order received',
                            //         () => Navigator.pop(context));
                            //     // ignore: use_build_context_synchronously
                            //     Navigator.pushReplacement(context,
                            //         routeFrave(page: CheckOutScreen()));
                            //   } else {
                            //     // ignore: use_build_context_synchronously
                            //     // modalError(
                            //     //     context,
                            //     //     'order faild ,'
                            //     //     ' try again',
                            //     //     () => Navigator.pop(context));
                            //   }
                            //   // Navigator.push(
                            //   //     context, routeFrave(page: CheckOutScreen()));
                            // }

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context, routeFrave(page: CheckOutScreen()));
                          } else {
                            // ignore: use_build_context_synchronously
                            modalError(
                                context,
                                'you can not add product $result with this quantity ,'
                                ' please decrease its amount',
                                () => Navigator.pop(context));
                          }

                          // dynamic response = await Chapa.paymentParameters(
                          //   context: context, // context
                          //   publicKey:
                          //       'CHASECK_TEST-LuyPQHmIruZaX970hr0f1PoUNxSSDGUl',
                          //   currency: 'ETB',
                          //   amount: cartController.totalAmount.toString(),
                          //   email: email,
                          //   phone: phone,
                          //   firstName: name,
                          //   lastName: 'common',
                          //   txRef:
                          //       'chewatatest-${cartController.totalAmount.toString()} ',
                          //   title: 'test',
                          //   desc: 'payment for delivery',
                          //   namedRouteFallBack:
                          //       '/checkoutPage', // fall back route name
                          // );
                          // print('hello try done');

                          // ignore: use_build_context_synchronously

                          // } catch (error) {
                          //   print('sad  catch done');
                          //   print('error= $error');
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Error: $error')));
                          // }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WithOutProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        //SvgPicture.asset('Assets/empty-cart.svg', height: 450),
        TextCustom(
          text: 'Without products',
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: ColorsFrave.primaryColor,
        )
      ],
    );
  }
}
