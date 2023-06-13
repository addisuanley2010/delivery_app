import 'package:chapasdk/chapa_payment%20initializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/btn_frave.dart';
import 'package:delivery/ui/client/component/modal_error.dart';
import 'package:delivery/ui/client/component/modal_success.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chapasdk/chapasdk.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    final cartController = Provider.of<CartController>(context);
    if (user!.uid != null) {
      getcustomer();
    }
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const TextCustom(text: 'Order', fontWeight: FontWeight.w500),
        centerTitle: true,
        elevation: 0,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColor, size: 19),
              TextCustom(
                  text: 'Back ', fontSize: 17, color: ColorsFrave.primaryColor)
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CheckoutAddress(),
              const SizedBox(height: 20.0),
              _CheckoutPaymentMethods(),
              const SizedBox(height: 20.0),
              _DetailsTotal(),
              const SizedBox(height: 20.0),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: BtnFrave(
                      text: 'Order',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: (cartController.items.isNotEmpty)
                          ? ColorsFrave.primaryColor
                          : ColorsFrave.secundaryColor,
                      onPressed: () async {
                        double total = cartController.totalAmount;
                        if (cartController.items.isNotEmpty) {
                          dynamic result =
                              await cartController.placeOrder(user.uid);
                          // print('${result}');
                          if (result == true) {
                            print('my bag screen : cart added successfully');
                            // ignore: use_build_context_synchronously

                            try {
                              dynamic response = await Chapa.paymentParameters(
                                context: context, // context
                                publicKey:
                                    'CHASECK_TEST-LuyPQHmIruZaX970hr0f1PoUNxSSDGUl',
                                currency: 'ETB',
                                amount: total.toString(),
                                email: email,
                                phone: phone,
                                firstName: name,
                                lastName: 'common',
                                txRef: 'chewatatest-${total.toString()}',
                                title: 'test',
                                desc: 'payment for delivery',
                                namedRouteFallBack:
                                    '/checkoutPage', // fall back route name
                              );
                              print('hello try done');

                              // Navigator.pushReplacement(
                              //     context, routeFrave(page: CheckOutScreen()));
                            } catch (error) {
                              print('sad  catch done');
                              print('error= $error');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')));
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            modalError(
                                context,
                                'order faild ,'
                                ' try again',
                                () => Navigator.pop(context));
                          }
                          // Navigator.push(
                          //     context, routeFrave(page: CheckOutScreen()));
                        }
                      },
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
    //);
  }
}

class _DetailsTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final cardBloc = BlocProvider.of<CartBloc>(context);
    final cartController = Provider.of<CartController>(context);

    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 190,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextCustom(text: 'Order Summary', fontWeight: FontWeight.w500),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Subtotal', color: Colors.grey),
              TextCustom(
                  text: '\$ ${cartController.totalAmount}', color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TextCustom(text: 'IGV', color: Colors.grey),
              TextCustom(text: '\$ 2.5', color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TextCustom(text: 'Shipping', color: Colors.grey),
              TextCustom(text: '\$ 0.00', color: Colors.grey),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Total', fontWeight: FontWeight.w500),
              TextCustom(
                  text: '\$ ${cartController.totalAmount}0',
                  fontWeight: FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }
}

class _CheckoutPaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final paymentBloc = BlocProvider.of<PaymentsBloc>(context);

    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TextCustom(text: 'Payment Methods', fontWeight: FontWeight.w500),
              // BlocBuilder<PaymentsBloc, PaymentsState>(
              //     builder: (_, state) => TextCustom(
              //         text: state.typePaymentMethod,
              //         color: ColorsFrave.primaryColor,
              //         fontWeight: FontWeight.w500,
              //         fontSize: 16)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 5.0),
          SizedBox(
            height: 30,
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 45,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      //image: NetworkImage('${Environment.endpointBase}${listProductDetails[i].picture}')
                      image: AssetImage('assets/Logo/chapa.jpg'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('chapa'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CheckoutAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('check out after payment done sucess');
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 95,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TextCustom(text: 'Shipping Address', fontWeight: FontWeight.w500),
              // InkWell(
              //     onTap: () => Navigator.push(
              //         context, routeFrave(page: SelectAddressScreen())),
              //     child: const TextCustom(
              //         text: 'Change',
              //         color: ColorsFrave.primaryColor,
              //         fontSize: 17))
            ],
          ),
          const Divider(),
          const SizedBox(height: 5.0),
          const Text('Addis abeba')
        ],
      ),
    );
  }
}
