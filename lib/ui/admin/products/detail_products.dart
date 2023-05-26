import 'package:delivery/ui/admin/products/product_update.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String productName;
  final String productDescription;
  final double productPrice;
  final String imageURL;
  final String amount;
  final String status;
  final String productId;
  ProductDetails({
    Key? key,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.imageURL,
    required this.amount,
    required this.status,
    required this.productId,
  }) : super(key: key);
  double? deviceHeight, deviceWidth; //have no use now

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height * 0.4;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  height: deviceHeight,
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Product Name:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 180, 26, 26),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Text(
                            productName,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 180, 26, 26),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Price: $productPrice birr',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 26, 26),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Amount: $amount',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 26, 26),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Status: $status',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 26, 26),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 180, 26, 26),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            productDescription,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 180, 26, 26),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        productDescription,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 26, 26),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                          const SizedBox(width: 8.0),
                          const Text(
                            '4.5',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ProductUpdate(productId:productId)),
                              );
                            },
                            icon: const Icon(Icons.update),
                            label: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle delete action
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
