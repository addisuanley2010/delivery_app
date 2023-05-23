class Orders {
  final String orderId;
  final String clientId;
  final String deliveryId;
  final String addressId;
  final String status;
  final double totalCost;
  final DateTime createdAt;

  Orders({
    required this.orderId,
    required this.clientId,
    required this.deliveryId,
    required this.addressId,
    required this.status,
    required this.totalCost,
    required this.createdAt,
  });
}
