import 'package:flutter/material.dart';
import 'package:delivery/ui/admin/components/components.dart';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';

class OrdersAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> payType = ["addisu","abebe", "aster","fantaye"];
    return DefaultTabController(
        length: 4,
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
                // indicator: FraveIndicatorTabBar(),
                isScrollable: true,
                tabs: List<Widget>.generate(
                    4,
                    (i) => Tab(
                        child: Text(payType[i],
                            style:
                                GoogleFonts.getFont('Roboto', fontSize: 17))))),
          ),
          body: TabBarView(
            children: payType
                .map((e) => FutureBuilder(
                    // future: ordersServices.getOrdersByStatus(e),
                    builder: (context, snapshot) =>
                        Column(
                            children: const [
                              // ShimmerFrave(),
                              SizedBox(height: 10),
                              // ShimmerFrave(),
                              SizedBox(height: 10),
                              // ShimmerFrave(),
                            ],
                          )
                          )
                          )
                .toList(),
          ),
        ));
  }
}

class _ListOrders extends StatelessWidget {
  final List listOrders;

  const _ListOrders({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOrders.length,
      itemBuilder: (context, i) => _CardOrders(),
    );
  }
}

class _CardOrders extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.blueGrey, blurRadius: 8, spreadRadius: -5)
          ]),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        // onTap: () => Navigator.push(context,
        //     routeFrave(page: OrderDetailsScreen(order: orderResponse))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: 'ORDER ID: ${1}'),
              const Divider(),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(
                      text: 'Date',
                      fontSize: 16,
                      color: ColorsFrave.secundaryColor),
                  TextCustom(
                      text:"12/12/12",
                      fontSize: 16),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(
                      text: 'Client',
                      fontSize: 16,
                      color: ColorsFrave.secundaryColor),
                  TextCustom(text: "nothing", fontSize: 16),
                ],
              ),
              const SizedBox(height: 10.0),
              const TextCustom(
                  text: 'Address shipping',
                  fontSize: 16,
                  color: ColorsFrave.secundaryColor),
              const SizedBox(height: 5.0),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextCustom(
                      text: "stupid", fontSize: 16, maxLine: 2)),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
