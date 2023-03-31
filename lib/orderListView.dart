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
  const OrderListView({Key? key, required this.orderList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stats = [
      "Cancel Order",
      "Checked In",
      "Transaction Success",
      "Canceled",
      "Canceled by System",
    ];
    var cardColor = [
      Colors.red,
      Color.fromARGB(255, 199, 184, 46),
      Color.fromARGB(255, 53, 117, 56),
      Color.fromARGB(255, 196, 74, 65),
      Color.fromARGB(255, 196, 74, 65),
    ];
    var textColor = [
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 0, 0, 0),
    ];
    var textColorDisabled = [
      Color.fromARGB(255, 41, 41, 41),
      Color.fromARGB(255, 41, 41, 41),
      Color.fromARGB(255, 41, 41, 41),
      Color.fromARGB(255, 41, 41, 41),
      Color.fromARGB(255, 41, 41, 41),
    ];
    final cardThumbnail = Container(
      margin: EdgeInsets.only(left: 11, top: 11),
      child: 
       ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),//add border radius here
        child: 
        SizedBox.fromSize(
          size: Size.fromRadius(50), // Image radius
          child: Image.network(orderList.mall.fotoMall, fit: BoxFit.cover),
        ),
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(color: Color.fromARGB(200, 255, 255, 255), fontSize: 7.0, fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(color: Color.fromARGB(200, 255, 255, 255), fontSize: 7.0);
    final orderTimeTextStyle = regularTextStyle.copyWith(color: Color.fromARGB(200, 255, 255, 255), fontSize: 8.0);
    final headerTextStyle = baseTextStyle.copyWith(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600);

    Widget _cardValue({required String value, required String image}) {
      return Row(children: <Widget>[
        Image.asset(image, height: 12.0),
        Container(width: 8.0),
        Text(value, style: regularTextStyle),
      ]);
    }

    final cardCardContent = Container(
      margin: EdgeInsets.fromLTRB(120.0, 15.0, 15, 0.0),
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget> [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Container(height: 3.0),
              Text(orderList.mall.namaMall, style: headerTextStyle),
              Container(height: 5.0),
              Text(orderList.mall.alamatMall, style: subHeaderTextStyle),
              Container(margin: EdgeInsets.symmetric(vertical: 8.0), height: 2.0, width: 30.0, color: Color(0xff00c6ff)),              
            ],
          ),
                    
          Positioned(
              right: 140.0,
              bottom: 10.0,
              child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.info_outline),
                  color: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 25,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {

                        return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                          scrollable: true,
                          title: Text("Invoice"),
                          content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text("Mall"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 40.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.mall.namaMall),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Alamat"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 60.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.mall.alamatMall),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Status"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 60.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.progress == 0 ? "Waiting for Checkin" : stats[orderList.progress],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: textColor[orderList.progress],
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Jam Operasi"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 100.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.mall.openTimeMall),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Expired in"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 80.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.expired_time ?? "-"),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Order Time"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 80.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.order_time ?? "-"),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Check-in"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 80.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.checkIn_time ?? "-"),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Check-Out"),
                                  Container(margin: EdgeInsets.symmetric(vertical:5.0), height: 0.5, width: 80.0, color: Color.fromARGB(255, 107, 107, 107)),
                                  Text(orderList.checkOut_time ?? "-"),

                                ],
                              ),
                            actions: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 28.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                              style: ButtonStyle(
                                                      fixedSize: MaterialStateProperty.resolveWith<Size>(
                                                        (Set<MaterialState> states) {
                                                          return MediaQuery.of(context).size;
                                                        },
                                                      ),
                                                    ),
                                              child: Text("Close"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }
                                            )
                                  )
                                )
                              )
                            ],
                          );
                        },
                      );
                    });
                  },
                )
              ])
          ),
          Positioned(
              right: 5.0,
              bottom: 20.0,
              child: Column(
              children: [
                Text("Order Time : "+(orderList.order_time ?? "-"), style: orderTimeTextStyle),
                Container(height: 5.0),
                Container(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      height: 28.0,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.resolveWith<Size>(
                                (Set<MaterialState> states) {
                                  return MediaQuery.of(context).size;
                                },
                              ),
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return cardColor[orderList.progress];
                                },
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return orderList.progress != 0 ? textColorDisabled[orderList.progress] : Color.fromARGB(255, 31, 31, 31);
                                },
                              ),
                            ),
                          child: Text(
                            stats[orderList.progress],
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 40),
                          ),
                          
                          onPressed: orderList.progress != 0 ? null : (){
                              Alert(
                                context: context,
                                type: AlertType.info,
                                desc: "ingin membatalkan order ?",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(116, 116, 191, 1.0),
                                      Color.fromRGBO(52, 138, 199, 1.0),
                                    ]),
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
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
                                    color: Color.fromRGBO(0, 179, 134, 1.0),
                                  ),
                                ],
                              ).show();
                          },//(){},
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      )      
    );

    final cardCard = Container(
      child: cardCardContent,
      height: 124.0,
      margin: EdgeInsets.only(left: 0.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(130, 0, 0, 0),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );


    return Container(
      height: 150.0,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
      child: Stack(
        children: <Widget>[
          cardCard,
          cardThumbnail,
        ],
      ),
    );
  }
}
