class OrderResponse {
  final String orderId;
  final String clientId;
  final String deliveryId;
  final String addressId;
  final String status;
  final DateTime createdAt;
  final String name;
  final double price;
  final double quantity;
  final double totalCost;
  final String productId;
  final String imageUrl;

  OrderResponse({
    required this.orderId,
    required this.clientId,
    required this.deliveryId,
    required this.addressId,
    required this.status,
    required this.createdAt,
    required this.name,
    required this.price,
    required this.quantity,
    required this.totalCost,
    required this.productId,
    required this.imageUrl,
  });
}
