import 'package:flutter/material.dart';
import 'package:delivery/ui/admin/components/components.dart';

import 'package:delivery/constants/constants.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';

class OrderDetailsScreen extends StatelessWidget {


  const OrderDetailsScreen();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextCustom(text: 'Order N° ${23}'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded, size: 17, color: ColorsFrave.primaryColor ),
                TextCustom(text: 'Back', color: ColorsFrave.primaryColor, fontSize: 17)
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                        children: const [
                          // ShimmerFrave(),
                          SizedBox(height: 10.0),
                          // ShimmerFrave(),
                          SizedBox(height: 10.0),
                          // ShimmerFrave(),
                        ],
                      )
                
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Total', color: ColorsFrave.secundaryColor, fontSize: 22, fontWeight: FontWeight.w500),
                        TextCustom(text: '\$ ${12}0', fontSize: 22, fontWeight: FontWeight.w500),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Cliente:', color: ColorsFrave.secundaryColor, fontSize: 16),
                        TextCustom(text: 'what annaoying'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Date:', color: ColorsFrave.secundaryColor, fontSize: 16),
                        TextCustom(text: "12/21/12", fontSize: 16),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const TextCustom(text: 'Address shipping:', color: ColorsFrave.secundaryColor, fontSize: 16),
                    const SizedBox(height: 5.0),
                    TextCustom(text: "dfsdfk", maxLine: 2, fontSize: 16),
                    const SizedBox(height: 5.0),
                    ("status" == 'DISPATCHED')
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Delivery', fontSize: 17, color: ColorsFrave.secundaryColor),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('')
                                )
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            TextCustom(text: "hello", fontSize: 17)
                          ],
                        )
                      ],
                    ) : const SizedBox()
                  ],
                ),
              )
            ),
            ("status" == 'PAID OUT')
            ? Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     // BtnFrave(
              //     //   text: 'SELECT DELIVERY',
              //     //   fontWeight: FontWeight.w500,
              //     //   onPressed: () => modalSelectDelivery(context, order.orderId.toString()),
              //     // ) 
              //   ],
              // ),
            ) : const SizedBox()
          ],
        ),
    );
  }
}

class _ListProductsDetails extends StatelessWidget {
  
  final List listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) =>const Divider(),
      itemBuilder: (_, i) 
        => Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration:const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('')
                  )
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(text: listProductDetails[i].nameProduct, fontWeight: FontWeight.w500 ),
                  const SizedBox(height: 5.0),
                  TextCustom(text: 'Quantity: ${listProductDetails[i].quantity}', color: Colors.grey, fontSize: 17),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextCustom(text: '\$ ${listProductDetails[i].total}'),
                )
              )
            ],
          ),
        ),
    );
  }
}

