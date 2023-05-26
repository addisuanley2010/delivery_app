import 'package:delivery/services/database.dart';
import 'package:delivery/ui/admin/products/product_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
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

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double? deviceHeight, deviceWidth;
  bool isDeleting = false;
  //have no use now
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    void _showSnackbar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 181, 74, 110),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }

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
                      image: NetworkImage(widget.imageURL),
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
                            widget.productName,
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
                        'Price: ${widget.productPrice} birr',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 26, 26),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Amount: ${widget.amount}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 26, 26),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Status: ${widget.status}',
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
                            widget.productDescription,
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
                        widget.productDescription,
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
                                MaterialPageRoute(
                                    builder: (context) => ProductUpdate(
                                        productId: widget.productId)),
                              );
                            },
                            icon: const Icon(Icons.update),
                            label: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                          widget.status == 'not sold'
                              ? ElevatedButton.icon(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Deletion"),
                                          content: const Text(
                                              "Are you sure you want to delete?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCEL"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  isDeleting = true;
                                                });

                                                isDeleting
                                                    ? CircularProgressIndicator()
                                                    : "";

                                                // Perform the deletion logic
                                                await DatabaseService(
                                                        uid: currentUser!.uid)
                                                    .updateProductStatus(
                                                        widget.productId,
                                                        'sold');

                                                setState(() {
                                                  isDeleting = false;
                                                });
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();

                                                _showSnackbar(
                                                    " status changed to sold");
                                              },
                                              child: const Text(
                                                "DELETE",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Deletion"),
                                          content: const Text(
                                              "Are you sure you want to delete?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCEL"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                // Show the circular progress indicator

                                                setState(() {
                                                  isDeleting = true;
                                                });

                                                isDeleting
                                                    ? CircularProgressIndicator
                                                    : "";

                                                // Perform the deletion logic
                                                await DatabaseService(
                                                        uid: currentUser!.uid)
                                                    .updateProductStatus(
                                                        widget.productId,
                                                        'not sold');

                                                // Stop the// circular progress indicator
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();

                                                _showSnackbar(
                                                    " status changed to not sold");

                                                setState(() {
                                                  isDeleting = false;
                                                });
                                              },
                                              child: const Text(
                                                "RESTORE",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Restore'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                )
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
