import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/orderModel.dart';
import 'package:delivery/models/ordersResponse.dart';
import 'package:delivery/ui/client/component/date_custom.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';

class CardOrdersDelivery extends StatelessWidget {
  final Orders orderResponse;
  final VoidCallback? onPressed;

  const CardOrdersDelivery({required this.orderResponse, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
          ]),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: 'ORDER ID: ${orderResponse.orderId}'),
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
                      text: DateCustom.getDateOrder(
                          orderResponse.createdAt.toString()),
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
                  TextCustom(text: orderResponse.clientId, fontSize: 9),
                ],
              ),
              const SizedBox(height: 10.0),
              // const TextCustom(
              //     text: 'Address shipping',
              //     fontSize: 16,
              //     color: ColorsFrave.secundaryColor),
              const SizedBox(height: 5.0),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextCustom(
                      text: orderResponse.addressId, fontSize: 16, maxLine: 2)),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
