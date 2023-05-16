import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<List<ApiConstant>> fetchAlbum() async {
  List<Map<String, dynamic>> _map = [];
  const _baseurl = 'www.cheapshark.com';
  const _path = '/api/1.0/deals?pageNumber=1&onSale=1';


  Uri uri = Uri.https(_baseurl,_path);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("API ACCESS OK!");
    print(response.body);
    //_map = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    var jsonResponse = json.decode(response.body);
    List<ApiConstant> deals = [];
    for (var u in jsonResponse){
      ApiConstant cons = ApiConstant(title: u['title'], salePrice: u['salePrice'], savings: u['savings']);
      deals.add(cons);
    }

    
    return deals;
    //return ApiConstant.fromJson(_map[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load album');
  }
}


//https://27coupons.p.rapidapi.com/coupons/trending/nye30a14KDwLNHEp5UJlHHhW28nlr59n
class ApiConstant {
  final String title;
  final String salePrice;
  final String savings;



  const ApiConstant({
    required this.title,
    required this.salePrice,
    required this.savings
  });

  factory ApiConstant.fromJson(Map<String, dynamic> json) {
    return ApiConstant(
      title: json['title'],
      salePrice: json['salePrice'],
      savings: json['savings'],
    );
  }
}

