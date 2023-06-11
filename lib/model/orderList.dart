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
  OrderedSpotParkir ordered_spot_parkir;
  int progress;
  String? expired_time;
  String? order_time;
  String? checkIn_time;
  String? checkOut_time;
  String? durasi_parkir;
  String? estimasi_harga;

  OrderList({
    required this.id, 
    required this.mall, 
    required this.ordered_spot_parkir,
    required this.progress, 
    required this.expired_time, 
    required this.order_time, 
    required this.checkIn_time, 
    required this.checkOut_time, 
    required this.durasi_parkir, 
    required this.estimasi_harga});

  factory OrderList.fromJson(
    Map<String, dynamic> json) => OrderList(
      id: json['id'], 
      mall: MallList.fromJson(json['mall']), 
      ordered_spot_parkir: OrderedSpotParkir.fromJson(json['spot_parkir']),
      progress: json['progress'], 
      expired_time: json['expired_time'], 
      order_time: json['order_time'], 
      checkIn_time: json['checkin_time'], 
      checkOut_time: json['checkout_time'], 
      durasi_parkir: json['durasi_parkir'], 
      estimasi_harga: json['estimasi_harga']);
}
