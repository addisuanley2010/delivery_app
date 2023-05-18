
class OrdersByStatusResponse {

  final bool resp;
  final String msg;
  final List<OrdersResponse> ordersResponse;

  OrdersByStatusResponse({
    required this.resp,
    required this.msg,
    required this.ordersResponse,
  });

  factory OrdersByStatusResponse.fromJson(Map<String, dynamic> json) => OrdersByStatusResponse(
    resp: json["resp"],
    msg: json["msg"],
    ordersResponse: json["ordersResponse"] != null ? List<OrdersResponse>.from(json["ordersResponse"].map((x) => OrdersResponse.fromJson(x))) : [],
  );
}

class OrdersResponse {

  final String orderId;
  final String deliveryId;
  final String delivery;
  final String deliveryImage;
  final String clientId;
  final String cliente;
  final String clientImage;
  final String clientPhone;
  final String addressId;
  final String street;
  final String reference;
  final String latitude;
  final String longitude;
  final String status;
  final String payType;
  final String amount;
  final DateTime currentDate;

  OrdersResponse({
    required this.orderId,
    required this.deliveryId,
    required this.delivery,
    required this.deliveryImage,
    required this.clientId,
    required this.cliente,
    required this.clientImage,
    required this.clientPhone,
    required this.addressId,
    required this.street,
    required this.reference,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.payType,
    required this.amount,
    required this.currentDate,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    orderId: json["order_id"]??"addisu anley",
    deliveryId: json["delivery_id"] ?? "abebe delivery id",
    delivery: json["delivery"] ?? 'delivery',
    deliveryImage: json["deliveryImage"] ?? 'image naem',
    clientId: json["client_id"]??"aster awoke",
    cliente: json["cliente"]??'kiros alemayehu',
    clientImage: json["clientImage"]??'tsegenet',
    clientPhone: json["clientPhone"] ?? '091234',
    addressId: json["address_id"]??'addis abeba',
    street: json["street"]??'addis',
    reference: json["reference"]??'welo',
    latitude: json["Latitude"]??'0000',
    longitude: json["Longitude"]??'1111',
    status: json["status"]??'Delivered',
    payType: json["pay_type"]??'cahapa',
    amount: json["amount"]??"12.0",
    currentDate: DateTime.parse(json["currentDate"]),
  );
}
