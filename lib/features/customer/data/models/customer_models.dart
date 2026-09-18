import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String nameKey;
  final IconData icon;

  CategoryModel({required this.id, required this.nameKey, required this.icon});
}

class StoreModel {
  final String id;
  final String name;
  final double rating;
  final String deliveryTime;
  final double deliveryFee;
  final String categoryKey;

  StoreModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.categoryKey,
  });
}

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String storeName;
  final double rating;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.storeName,
    required this.rating,
  });
}
