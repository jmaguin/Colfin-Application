import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<ApiConstant> fetchAlbum() async {
  List<Map<String, dynamic>> _map = [];
  const _baseurl = 'www.cheapshark.com';
  const _path = '/api/1.0/deals?storeID=1&upperPrice=15';
  const _query = {'pageNumber': '1', 'onSale':'1'};
  // //const _query = {'key' : 'nye30a14KDwLNHEp5UJlHHhW28nlr59n'};
  // const Map<String, String> _headers = {
  //   'Content-Type': 'application/json',
  // 'X-RapidAPI-Key': '90697b2f7emsha5a95f202e1969ap1c28c6jsn28f9937b63b9',
  //   'X-RapidAPI-Host': 'amazon-deals-coupons.p.rapidapi.com',
  //   'useQueryString' : 'true'
  // };

  Uri uri = Uri.https(_baseurl,_path,_query);
  final response = await http.get(uri);
  //final response = await http.post(uri, headers: _headers);
  // final response = await http.get(uri, headers: {
  //     // 'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'x-rapidapi-key': '90697b2f7emsha5a95f202e1969ap1c28c6jsn28f9937b63b9',
  //     'x-rapidapi-host': 'get-promo-codes.p.rapidapi.com',
  //     'useQueryString' : 'true'
  //   },);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("API ACCESS OK!");
    print(response.body);
    _map = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return ApiConstant.fromJson(_map[0]);
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

