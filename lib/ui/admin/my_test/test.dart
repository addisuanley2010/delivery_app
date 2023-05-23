import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/admin/my_test/test_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../helpers/frave_indicator.dart';
import '../helpers/pay_type.dart';

class TestShop extends StatefulWidget {
  const TestShop({super.key});

  @override
  State<TestShop> createState() => _ListDeliverysScreenState();
}

class _ListDeliverysScreenState extends State<TestShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: payType.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const TextCustom(text: 'List Orders', fontSize: 20),
            centerTitle: true,
            leadingWidth: 80,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_back_ios_new_outlined,
                      color: ColorsFrave.primaryColor, size: 17),
                  TextCustom(
                      text: 'Back',
                      color: ColorsFrave.primaryColor,
                      fontSize: 17)
                ],
              ),
            ),
            bottom: TabBar(
              indicatorWeight: 2,
              labelColor: ColorsFrave.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicator: FraveIndicatorTabBar(),
              isScrollable: true,
              tabs: List<Widget>.generate(
                payType.length,
                (i) => Tab(
                  child: Text(
                    payType[i],
                    style: GoogleFonts.getFont('Roboto', fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
              children: payType.map((tabName) {
            return _ListDelivery(
              tabName: tabName,
            );
          }).toList()),
        ),
      ),
    );
  }
}

class _ListDelivery extends StatelessWidget {
  final String tabName;

  const _ListDelivery({
    required this.tabName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: tabName)
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
                    String customerId = documents[i].get('clientId');
                    String orderId = documents[i].id;
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('customers')
                          .doc(customerId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> customerSnapshot) {
                        if (!customerSnapshot.hasData) {
                          return const SizedBox();
                        }
                        final customerData = customerSnapshot.data!.data();
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.blueGrey,
                                    blurRadius: 8,
                                    spreadRadius: -5)
                              ]),
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              String status = documents[i].get('status');
                              String name = customerData != null
                                  ? (customerData
                                          as Map<String, dynamic>)['email'] ??
                                      ''
                                  : '';
                              String address = customerData != null
                                  ? (customerData
                                          as Map<String, dynamic>)['address'] ??
                                      ''
                                  : '';
                              double totalCost = documents[i].get('totalCost');
                              Timestamp timestamp =
                                  documents[i].get('createdAt');
                              DateTime date = timestamp.toDate();
                              String formattedDateTime =
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(date);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                    name: name,
                                    address: address,
                                    status: status,
                                    customerId: customerId,
                                    date: formattedDateTime,
                                    orderId: orderId,
                                    totalCost: totalCost,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const TextCustom(
                                          text: "Order ID:", fontSize: 20),
                                      TextCustom(
                                          text: (i+1).toString(),
                                          // text: documents[i].id,
                                          fontSize: 16),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextCustom(
                                          text: 'Date',
                                          fontSize: 20,
                                          color: ColorsFrave.secundaryColor),
                                      TextCustom(
                                        text: DateFormat('yyyy-MM-dd').format(
                                          (documents[i].get('createdAt')
                                                  as Timestamp)
                                              .toDate(),
                                        ),
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextCustom(
                                          text: "Customer",
                                          fontSize: 20,
                                          color: ColorsFrave.secundaryColor),
                                      TextCustom(
                                        text: customerData != null
                                            ? (customerData as Map<String,
                                                    dynamic>)['name'] ??
                                                ''
                                            : '',
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextCustom(
                                          text: "Address Shipping",
                                          fontSize: 20,
                                          color: ColorsFrave.secundaryColor),
                                      TextCustom(
                                          text: customerData != null
                                              ? (customerData as Map<String,
                                                      dynamic>)['address'] ??
                                                  ''
                                              : ''),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/empty-cart.svg',
                          height: 290),
                      const SizedBox(height: 20.0),
                      const TextCustom(
                          text: ' empty order',
                          color: ColorsFrave.primaryColor,
                          fontSize: 20)
                    ],
                  ),
                );
        },
      ),
    );
  }
}
