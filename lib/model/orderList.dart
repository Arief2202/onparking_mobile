// ignore_for_file: camel_case_types, unnecessary_null_comparison, file_names, non_constant_identifier_names

import 'package:onparking_mobile/model/mallList.dart';
import 'package:onparking_mobile/model/user.dart';

class OrderListResult {
  OrderListResult({
    required this.success,
    required this.user,
    required this.totalOrders,
    required this.orders,
    required this.pesan,
  });

  bool success;
  UserModel user;
  int totalOrders;
  List<OrderList> orders;
  String pesan;

  factory OrderListResult.fromJson(Map<String, dynamic> json) => OrderListResult(
        success: json["success"],
        user: UserModel.fromJson(json['user']),
        totalOrders: json["totalOrders"],
        orders: List<OrderList>.from((json["orders"] as List).map((x) => OrderList.fromJson(x)).where((content) => content.id != null)),
        pesan: json["pesan"],
      );
}

class OrderList {
  int id;
  MallList mall;
  int progress;
  String? expired_time;
  String? order_time;
  String? checkIn_time;
  String? checkOut_time;

  OrderList({
    required this.id, 
    required this.mall, 
    required this.progress, 
    required this.expired_time, 
    required this.order_time, 
    required this.checkIn_time, 
    required this.checkOut_time});

  factory OrderList.fromJson(
    Map<String, dynamic> json) => OrderList(
      id: json['id'], 
      mall: MallList.fromJson(json['mall']), 
      progress: json['progress'], 
      expired_time: json['expired_time'], 
      order_time: json['order_time'], 
      checkIn_time: json['checkIn_time'], 
      checkOut_time: json['checkOut_time']);
}