// Define a class to hold order detail data

class OrderDetail {
  final String orderId;
  final String name;
  final int price;
  final int quantity;
  final String productId;
  final String imageUrl;

  OrderDetail({
    required this.orderId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.imageUrl,
  });


  // Define a factory constructor to create OrderDetail objects from map data
  factory OrderDetail.fromMap(Map<String, dynamic> data) {
    print(data);

    return OrderDetail(
      orderId: data['orderId'],
      name: data['name'],
      price: data['price'],
      quantity: data['quantity'],
      productId: data['productId'],
      imageUrl: data['imageUrl'],
    );
  }
}
