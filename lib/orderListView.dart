// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, sort_child_properties_last, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unnecessary_new, unnecessary_string_escapes, unused_local_variable, sized_box_for_whitespace

import 'package:onparking_mobile/model/orderList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onparking_mobile/StatusPage.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:onparking_mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class OrderListView extends StatelessWidget {
  final OrderList orderList;
  // final MallList mall = orderList.mall;
  // final MallList
  const OrderListView({Key? key, required this.orderList}) : super(key: key);
  // var array = new List(6);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    var stats = [
      "Waiting For Check-in",
      "Checked In",
      "Checked Out",
      "Canceled",
      "Canceled by System",
    ];
    var cardColor = [
      Colors.yellow,
      Colors.yellow,
      Colors.green,
      Colors.red,
      Colors.red,
    ];
    var textColor = [
      Colors.black,
      Colors.black,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
    return Card(
      margin: EdgeInsets.all(15.0),
      color: cardColor[orderList.progress],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Expanded(
          //   flex: 1,
          //   child:
          // ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      orderList.mall.fotoMall,
                      // height: 150.0,
                      // width: 100.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      orderList.mall.namaMall,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: textColor[orderList.progress],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Text("Status :", style: TextStyle(color: textColor[orderList.progress])),
                  Text(stats[orderList.progress],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: textColor[orderList.progress],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Alamat :\n" + orderList.mall.alamatMall, style: TextStyle(color: textColor[orderList.progress])),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Jam Operasi :\n" + orderList.mall.openTimeMall, style: TextStyle(color: textColor[orderList.progress])),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(orderList.mall.alamatMall),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text("Expired :\n" + (orderList.expired_time ?? "-"),
                      style: TextStyle(
                        color: textColor[orderList.progress],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Order Time :\n" + (orderList.order_time ?? "-"),
                      style: TextStyle(
                        color: textColor[orderList.progress],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Check-in :\n" + (orderList.checkIn_time ?? "-"),
                      style: TextStyle(
                        color: textColor[orderList.progress],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Check-Out :\n" + (orderList.checkOut_time ?? "-"),
                      style: TextStyle(
                        color: textColor[orderList.progress],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  if (orderList.progress == 0)
                    SizedBox(
                      height: 10,
                    ),
                  if (orderList.progress == 0)
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                      width: double.infinity,
                      // height: MediaQuery.of(context).size.width / 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () async {
                          var url = Uri.parse(globals.api + '/order/cancel');
                          final response = await http.post(url, body: {'order_id': (orderList.id).toString(), 'user_id': (globals.user_id).toString(), 'user_password': (globals.user_password).toString()});
                          Map<String, dynamic> parsed = jsonDecode(response.body);
                          Alert(
                            context: context,
                            type: parsed["success"] ? AlertType.success : AlertType.error,
                            title: parsed["success"] ? parsed["pesan"] : "Cancel Order Failed!",
                            desc: parsed["success"] ? '' : parsed["pesan"],
                            buttons: [
                              DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    parsed["success"] ? Phoenix.rebirth(context) : Navigator.pop(context);
                                    parsed["success"] ? '' : Navigator.pop(context);
                                    parsed["success"]
                                        ? ''
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) {
                                              return StatusPage();
                                            }),
                                          );
                                  })
                            ],
                          ).show();
                        },
                        child: Text(
                          "Cancel Order",
                          // style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
