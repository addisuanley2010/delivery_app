import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/admin/components/btn_frave.dart';
import 'package:flutter/material.dart';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';

class OrderDetailsScreen extends StatelessWidget {
  // const OrderDetailsScreen({required OrdersResponse order});
  final String name;
  final String address;
  final String status;
  final String customerId;
  const OrderDetailsScreen(
      {super.key,
      required this.name,
      required this.address,
      required this.status,
      required this.customerId});
  final int a = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustom(text: 'Order N° 1'),
        // title: TextCustom(text: 'Order N° ${order.orderId}'),

        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded,
                  size: 17, color: ColorsFrave.primaryColor),
              TextCustom(
                  text: 'Back', color: ColorsFrave.primaryColor, fontSize: 17)
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .where('client_id', isEqualTo: customerId)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('client_id', isEqualTo: customerId)
                          .snapshots();
                          //                           final productData = productSnapshot.data?.data();

                      return _ListProductsDetails(
                          listProductDetails: snapshot.data!.docs);
                    }
                  })),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextCustom(
                        text: 'Total',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                    TextCustom(
                        // text: '\$ ${order.amount}0',
                        text: "order amount 0",
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextCustom(
                        text: 'Cliente:',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 16),
                    // TextCustom(text: '${order.cliente}'),
                    TextCustom(text: 'addisu anley'),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextCustom(
                        text: 'Date:',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 16),
                    // TextCustom(
                    //     text: DateCustom.getDateOrder(
                    //         order.currentDate.toString()),
                    //     fontSize: 16),
                    TextCustom(text: "12/12/12", fontSize: 16),
                  ],
                ),
                const SizedBox(height: 10.0),
                const TextCustom(
                    text: 'Address shipping:',
                    color: ColorsFrave.secundaryColor,
                    fontSize: 16),
                const SizedBox(height: 5.0),
                const TextCustom(
                    text: "order.reference", maxLine: 2, fontSize: 16),
                const SizedBox(height: 5.0),
                // (order.status == 'DISPATCHED')
                (a == 1)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustom(
                              text: 'Delivery',
                              fontSize: 17,
                              color: ColorsFrave.secundaryColor),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(''
                                            // '${Environment.endpointBase}${order.deliveryImage}'
                                            ))),
                              ),
                              const SizedBox(width: 10.0),
                              const TextCustom(
                                  text: "order.delivery", fontSize: 17)
                            ],
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          )),
          // (order.status == 'PAID OUT')
          (a == 2)
              ? Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BtnFrave(
                        text: 'SELECT DELIVERY',
                        fontWeight: FontWeight.w500,
                        onPressed: () {
                          // modalSelectDelivery(
                          //   context, order.orderId.toString())
                        },
                      )
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class _ListProductsDetails extends StatelessWidget {
  // final List listProductDetails;
  final List<DocumentSnapshot> listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> documents = listProductDetails;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => const Divider(),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: NetworkImage(''))),
            ),
            const SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                    // text: "laptop",
                    text: documents[i].get('address_id'),
                    fontWeight: FontWeight.w500),
                SizedBox(height: 5.0),
                TextCustom(
                    // text: 'Quantity: ${listProductDetails[i].address_id}',
                    text: 'Quantity: 100',
                    color: Colors.grey,
                    fontSize: 17),
              ],
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: const TextCustom(text: '\$ 200'),

              // child: TextCustom(text: '\$ ${listProductDetails[i].total}'),
            ))
          ],
        ),
      ),
    );
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:delivery/constants/constants.dart';
// import 'package:delivery/ui/admin/components/text_custom.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class OrderDetailsScreen extends StatelessWidget {
//   final String name;
//   final String address;
//   final String status;
//   final String customerId;

//   const OrderDetailsScreen({
//     super.key,
//     required this.name,
//     required this.address,
//     required this.status,
//     required this.customerId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(16.0),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('orders')
//               .where('client_id', isEqualTo: customerId)
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final List<DocumentSnapshot> documents = snapshot.data!.docs;

//             return documents.isNotEmpty
//                 ? ListView.builder(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0, vertical: 10.0),
//                     itemCount: documents.length,
//                     itemBuilder: (context, i) {
//                       String productId = documents[i].get('product_id');
//                       return StreamBuilder<DocumentSnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('products')
//                             .doc(productId)
//                             .snapshots(),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<DocumentSnapshot> productSnapshot) {
//                           if (!productSnapshot.hasData) {
//                             return const SizedBox();
//                           }

//                           final productData = productSnapshot.data?.data();

//                           return Container(
//                             margin: const EdgeInsets.all(15.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Colors.blueGrey,
//                                       blurRadius: 8,
//                                       spreadRadius: -5)
//                                 ]),
//                             width: MediaQuery.of(context).size.width,
//                             child: InkWell(
//                               onTap: () {},
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20.0, vertical: 10.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const TextCustom(text: "name of customer"),
//                                     TextCustom(
//                                         text: documents[i].get('address_id'),
//                                         fontSize: 16,
//                                         color: ColorsFrave.secundaryColor),
//                                     const Divider(),
//                                     const SizedBox(height: 10.0),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const TextCustom(
//                                             text: "name of product"),
//                                         TextCustom(
//                                             text: productData != null
//                                                 ? (productData as Map<String,
//                                                         dynamic>)['name'] ??
//                                                     ''
//                                                 : '',
//                                             fontSize: 16,
//                                             color: ColorsFrave.secundaryColor),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   )
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/empty-cart.svg',
//                           height: 290,
//                         ),
//                         const SizedBox(height: 20.0),
//                         const TextCustom(
//                           text: ' empty order',
//                           color: ColorsFrave.primaryColor,
//                           fontSize: 20,
//                         )
//                       ],
//                     ),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }
