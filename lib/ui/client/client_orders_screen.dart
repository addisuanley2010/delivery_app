import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/orderModel.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/orderService.dart';
import 'package:delivery/ui/client/client_details_order_screen.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/date_custom.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ClientOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextCustom(text: 'My Orders', fontSize: 20),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColor, size: 17),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor)
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<Orders>>(
          stream: OrderService(uid: user!.uid).getOrdersByClientId,
          builder: (context, snapshot) => (!snapshot.hasData)
              ? Column(
                  children: const [
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                  ],
                )
              : _ListOrdersClient(listOrders: snapshot.data!)),
    );
  }
}

class _ListOrdersClient extends StatelessWidget {
  final List<Orders> listOrders;

  const _ListOrdersClient({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return (listOrders.length != 0)
        ? ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            itemCount: listOrders.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  routeFrave(
                      page: ClientDetailsOrderScreen(
                          orderClient: listOrders[i]))),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                            text: 'ORDER # ${listOrders[i].orderId}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsFrave.primaryColor),
                        TextCustom(
                            text: listOrders[i].status,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (listOrders[i].status == 'DELIVERED'
                                ? ColorsFrave.primaryColor
                                : ColorsFrave.secundaryColor)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                            text: 'AMOUNT',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        TextCustom(
                            text: '\$ ${listOrders[i].totalCost}0',
                            fontSize: 16)
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                            text: 'DATE',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        TextCustom(
                            text: DateCustom.getDateOrder(
                                listOrders[i].createdAt.toString()),
                            fontSize: 15)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : SvgPicture.asset('Assets/empty-cart.svg');
  }
}
