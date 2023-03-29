// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/mallList.dart';
import '../model/orderList.dart';
import 'package:onparking_mobile/globals.dart' as globals;

class ApiService {
  Future<MallListResult> readMall() async {
    var url = Uri.parse(globals.api);
    final response = await http.post(url);
    print(response.body);
    if (response.statusCode == 200) {
      return MallListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<OrderListResult> readOrder(context) async {
    var url = Uri.parse(globals.api + "/orders/" + (globals.user_id).toString());
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return OrderListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
