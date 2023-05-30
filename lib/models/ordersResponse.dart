class OrdersResponse {
  final int orderId;
  final int deliveryId;
  final String delivery;
  final String deliveryImage;
  final int clientId;
  final String cliente;
  final String clientImage;
  final String clientPhone;
  final int addressId;
  final String street;
  final String reference;
  final String latitude;
  final String longitude;
  final String status;
  final String payType;
  final double amount;
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
}
