import 'package:flutter/material.dart';
import 'package:flutter_finance_app/database.dart';

Future<List<DataObj>> convertPurchaseList() async {
  List<Map<String, dynamic>> purchaseList = await Database.getPurchases();

  List<DataObj> dataObjects = purchaseList.map((purchase) {
    return DataObj(
      id: purchase['id'].toInt(),
      name: purchase['name'],
      price: purchase['price'].toDouble(),
      category: purchase['category'],
    );
  }).toList();

  return dataObjects;
}

class DataObj {
  final int id;
  final String name;
  final double price;
  final String category;

  const DataObj({
    required this.id,
    required this.name,
    required this.price,
    required this.category
  });
}