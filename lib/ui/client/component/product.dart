import 'package:flutter/material.dart';

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
