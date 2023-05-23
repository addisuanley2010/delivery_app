import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/admin/components/btn_frave.dart';
import 'package:flutter/material.dart';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetailsScreen extends StatelessWidget {
  // const OrderDetailsScreen({required OrdersResponse order});
  final String name;
  final String address;
  final String status;
  final String customerId;
  final String date;
  final String orderId;
  final double totalCost;
  const OrderDetailsScreen(
      {super.key,
      required this.name,
      required this.address,
      required this.status,
      required this.customerId,
      required this.date,
      required this.orderId,
      required this.totalCost});

  @override
  Widget build(BuildContext context) {
    print('detail called');
    final String a = status;

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
                      //                           final productData = productSnapshot.data?.data();
                      return _ListProductsDetails(orderId: orderId);
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
                  children:  [
                   const TextCustom(
                        text: 'Total',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                    TextCustom(
                        text: '${totalCost.toDouble()} birr',
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(
                        text: 'Customers:',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 16),
                    TextCustom(text: name),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(
                        text: 'Date:',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 16),
                    TextCustom(
                      text: date,
                      fontSize: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(
                        text: 'Address shipping:',
                        color: ColorsFrave.secundaryColor,
                        fontSize: 16),
                    TextCustom(text: address, maxLine: 2, fontSize: 16),
                  ],
                ),
                const SizedBox(height: 5.0),
                const SizedBox(height: 5.0),
                (a == 'DELIVERED')
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
          (a == 'PAID OUT')
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
  final String orderId;

  const _ListProductsDetails({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orderDetail')
            .where('orderId', isEqualTo: orderId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return (documents.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  itemCount: documents.length,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        documents[i].get('imageUrl')))),
                          ),
                          const SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                  text: documents[i].get('name'),
                                  fontWeight: FontWeight.w500),
                              const SizedBox(height: 5.0),
                              TextCustom(
                                  text:
                                      'Quantity: ${documents[i].get('quantity').toString()} ',
                                  color: Colors.grey,
                                  fontSize: 17),
                            ],
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: TextCustom(
                              text:
                                  ('${documents[i].get('quantity') * documents[i].get('price')}  birr')
                                      .toString(),
                            ),
                          ))
                        ],
                      ),
                    );
                  })
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/empty-cart.svg',
                          height: 290),
                      const SizedBox(height: 20.0),
                      const TextCustom(
                          text: ' Have no details',
                          color: ColorsFrave.primaryColor,
                          fontSize: 20)
                    ],
                  ),
                );
        });
  }
}
