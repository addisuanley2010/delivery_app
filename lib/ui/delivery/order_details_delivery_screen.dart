import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/orderDetailModel.dart';
import 'package:delivery/models/orderModel.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/orderService.dart';
import 'package:delivery/ui/client/component/btn_frave.dart';
import 'package:delivery/ui/client/component/date_custom.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersDetailsDeliveryScreen extends StatefulWidget {
  final Orders order;

  const OrdersDetailsDeliveryScreen({required this.order});

  @override
  _OrdersDetailsDeliveryScreenState createState() =>
      _OrdersDetailsDeliveryScreenState();
}

class _OrdersDetailsDeliveryScreenState
    extends State<OrdersDetailsDeliveryScreen> {
  //late MylocationmapBloc mylocationmapBloc;

  // @override
  // void initState() {
  //   mylocationmapBloc = BlocProvider.of<MylocationmapBloc>(context);
  //   mylocationmapBloc.initialLocation();
  //   super.initState();
  // }

  @override
  // void dispose() {
  //   mylocationmapBloc.cancelLocation();
  //   super.dispose();
  // }

  // void accessGps(PermissionStatus status, BuildContext context) {
  //   switch (status) {
  //     case PermissionStatus.granted:
  //       Navigator.pushReplacement(
  //           context, routeFrave(page: MapDeliveryScreen(order: widget.order)));
  //       break;
  //     case PermissionStatus.denied:
  //     case PermissionStatus.restricted:
  //     case PermissionStatus.limited:
  //     case PermissionStatus.permanentlyDenied:
  //       openAppSettings();
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //final orderBloc = BlocProvider.of<OrdersBloc>(context);
    final user = Provider.of<Users?>(context);

    // return BlocListener<OrdersBloc, OrdersState>(
    // listener: (context, state) {
    //   if (state is LoadingOrderState) {
    //     modalLoading(context);
    //   } else if (state is SuccessOrdersState) {
    //     Navigator.pop(context);
    //     modalSuccess(
    //         context,
    //         'ON WAY',
    //         () async =>
    //             accessGps(await Permission.location.request(), context));
    //   } else if (state is FailureOrdersState) {
    //     Navigator.pop(context);
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: TextCustom(text: state.error, color: Colors.white),
    //         backgroundColor: Colors.red));
    //   }
    // },
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextCustom(
              text: 'ORDER N# ${widget.order.orderId}',
              fontWeight: FontWeight.w500),
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
                child: StreamBuilder<List<OrderDetail>?>(
                    stream: OrderService(uid: user!.uid)
                        .getOrderDetailsById(widget.order.orderId.toString()),
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
                        : _ListProductsDetails(
                            listProductDetails: snapshot.data!))),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextCustom(
                          text: 'TOTAL',
                          color: ColorsFrave.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: '\$ ${widget.order.totalCost}',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextCustom(
                          text: 'PAYMENT',
                          color: ColorsFrave.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      TextCustom(text: 'Chapa', fontSize: 16),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextCustom(
                          text: 'CLIENT',
                          color: ColorsFrave.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/bg.png'),
                                  // image: NetworkImage( (widget.order.clientImage != '') ? '${Environment.endpointBase}${widget.order.clientImage}' : '${Environment.endpointBase}without-image.png')
                                )),
                          ),
                          const SizedBox(width: 10.0),
                          TextCustom(text: widget.order.clientId),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextCustom(
                          text: 'DATE',
                          color: ColorsFrave.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: DateCustom.getDateOrder(
                              widget.order.createdAt.toString()),
                          fontSize: 16),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextCustom(
                          text: 'ADDRESS',
                          color: ColorsFrave.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: widget.order.addressId,
                          maxLine: 1,
                          fontSize: 15),
                    ],
                  ),
                  const SizedBox(height: 15.0)
                ],
              ),
            ),
            (widget.order.status != 'DELIVERED')
                ? Container(
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // BlocBuilder<MylocationmapBloc, MylocationmapState>(
                        //   builder: (context, state) =>
                        BtnFrave(
                          text: widget.order.status == 'DISPATCHED'
                              ? 'START DELIVERY'
                              : 'finish delivery',
                          // : 'GO TO MAP',

                          color: widget.order.status == 'DISPATCHED'
                              ? Color(0xff0C6CF2)
                              : Colors.indigo,
                          fontWeight: FontWeight.w500,
                          // onPressed: () {
                          //   if (widget.order.status == 'DISPATCHED') {
                          //     if (state.location != null) {
                          //       orderBloc.add(OnUpdateStatusOrderOnWayEvent(
                          //           widget.order.orderId.toString(),
                          //           state.location!));
                          //     }
                          //   }
                          //   if (widget.order.status == 'ON WAY') {
                          //     Navigator.push(
                          //         context,
                          //         routeFrave(
                          //             page: MapDeliveryScreen(
                          //                 order: widget.order)));
                          //   }
                          // },

                          onPressed: () async {
                            if (widget.order.status == 'DISPATCHED') {
                              await Delivery(status: 'ON WAY', uid: user.uid)
                                  .updateOrderStatus(
                                      orderId: widget.order.orderId,
                                      status: 'ON WAY');
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (widget.order.status == 'ON WAY') {
                              Delivery(status: 'DELIVERED', uid: user.uid)
                                  .updateOrderStatus(
                                      orderId: widget.order.orderId,
                                      status: 'DELIVERED');
                            }
                          },
                        ),
                        //)
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ));
    //);
  }
}

class _ListProductsDetails extends StatelessWidget {
  final List<OrderDetail> listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                //image: NetworkImage('${Environment.endpointBase}${listProductDetails[i].picture}')
                image: AssetImage('assets/images/bg.png'),
              )),
            ),
            const SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                    text: listProductDetails[i].name,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 5.0),
                TextCustom(
                    text: 'Quantity: ${listProductDetails[i].quantity}',
                    color: Colors.grey,
                    fontSize: 17),
              ],
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: TextCustom(
                  text:
                      '\$ ${listProductDetails[i].quantity * listProductDetails[i].price}'),
            ))
          ],
        ),
      ),
    );
  }
}
