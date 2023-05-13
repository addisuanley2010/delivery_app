import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final int id;
  final String description;
  final String picture;
  final String nameProduct;
  final int price;
  final String status;
  final String category_id;

  const Product(
      {super.key,
      required this.id,
      required this.description,
      required this.picture,
      required this.nameProduct,
      required this.price,
      required this.status,
      required this.category_id});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// catagory list
class Catagory extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  const Catagory({
    super.key,
    required this.id,
    required this.name,
    required this.description,
  });

  factory Catagory.fromMap(Map<String, dynamic> map) {
    return Catagory(
      id: map['shopId'],
      name: map['name'],
      description: map['description'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
