import 'package:flutter/material.dart';

class CartClientScreen extends StatefulWidget {
  const CartClientScreen({super.key});

  @override
  State<CartClientScreen> createState() => _CartClientScreenState();
}

class _CartClientScreenState extends State<CartClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Text(" this is cart screen")),
    );
  }
}
