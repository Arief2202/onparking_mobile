// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:onparking_mobile/model/mallList.dart';
import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:onparking_mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class ListItemUser extends StatefulWidget {
  final MallList mall;
  const ListItemUser({Key? key, required this.mall}) : super(key: key);
  // const ListItemUser({
  //   Key? key,
  // }) : super(key: key);
  @override
  ListItemUserState createState() => ListItemUserState(mall: mall);
}

class ListItemUserState extends State<ListItemUser> {
  final MallList mall;

  ListItemUserState({required this.mall});

  String? lantai;
  List<String>? bloks;
  String? blok;
  // final List<String> blok;
  void initState() {
    super.initState();
  }
  @override
  
  // String? dropdownValue = mall.spot?.first.lantai;
  @override
  Widget build(BuildContext context) {
    final cardThumbnail = Container(
      margin: EdgeInsets.only(left: 11, top: 11),
      // alignment: FractionalOffset.centerLeft,
      child: 
       ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),//add border radius here
        child: 
        SizedBox.fromSize(
          size: Size.fromRadius(50), // Image radius
          child: Image.network(mall.fotoMall, fit: BoxFit.cover),
        ),
        
        // Image.network(
        //   mall.fotoMall,
        //   // height: 50,
        //   width: 50,
        //   ),//add image location here
      ),
      
      // CircleAvatar(
      //   radius: 50.0,
      //   backgroundImage: NetworkImage(mall.fotoMall),
      // ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(color: Color.fromARGB(200, 255, 255, 255), fontSize: 7.0, fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(color: Color.fromARGB(200, 255, 255, 255), fontSize: 7.0);
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
              Text(mall.namaMall, style: headerTextStyle),
              Container(height: 5.0),
              Text(mall.alamatMall, style: subHeaderTextStyle),
              Container(margin: EdgeInsets.symmetric(vertical: 8.0), height: 2.0, width: 30.0, color: Color(0xff00c6ff)),              
            ],
          ),
          Positioned(
              left: 0.0,
              bottom: 20.0,
              child: Column(
              children: [
                Row(children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          _cardValue(value: (mall.openTimeMall).toString(), image: 'assets/img/time_white.png'),
                        ],
                      ),
                      Container(height: 10.0),
                      Row(
                        children: [
                          _cardValue(value: (mall.orderCount).toString() + "/" + (mall.kuotaMall).toString(), image: 'assets/img/car_white.png'),
                        ],
                      ),
                    ],
                  ),                  
                ]),
              ])
          ),
          
          Positioned(
              right: 5.0,
              bottom: 20.0,
              child: Column(
              children: [
                Container(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 28.0,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if(mall.orderCount! < mall.kuotaMall){
                              setState(() {
                                lantai = mall.spot!.first.lantai;
                                bloks = mall.spot!.first.blok;
                                blok = bloks!.first;
                              });
                            }

                            mall.orderCount! < mall.kuotaMall
                                ? 
                                showDialog(
                                  context: context,
                                  builder: (context) {

                                    return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                      scrollable: true,
                                      title: Text(mall.namaMall),
                                      content: Form(
                                          child: Column(
                                            children: <Widget>[
                                              DropdownButtonFormField<String>(
                                                  value: lantai,
                                                  decoration: InputDecoration(
                                                    labelText:  "Lantai"
                                                  ),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      lantai = value;
                                                    });
                                                    for(var i = 0; i<mall.spot!.length; i++){
                                                      if(mall.spot!.elementAt(i).lantai == value){
                                                        setState(() {
                                                          bloks = mall.spot!.elementAt(i).blok;
                                                          blok = null;
                                                        });
                                                      }
                                                    }


                                                  },
                                                  items: mall.spot?.map<DropdownMenuItem<String>>((Spot value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value.lantai,
                                                      child: Text(value.lantai),
                                                    );
                                                  }).toList(),
                                              ),

                                              DropdownButtonFormField<String>(
                                                  value: blok,
                                                  decoration: InputDecoration(
                                                    labelText:  "Blok"
                                                  ),
                                                  onChanged: (String? value) {
                                                    // This is called when the user selects an item.
                                                    setState(() {
                                                      blok = value;

                                                    });
                                                  },
                                                  items: bloks?.map<DropdownMenuItem<String>>((String value) {

                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                              ),

                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              child: Text("Booking"),
                                              onPressed: () async {
                                                  var url = Uri.parse(globals.api + '/order');
                                                  final response = await http.post(url, body: {'mall_id': (mall.id).toString(), 'user_id': (globals.user_id).toString(), 'lantai': (lantai).toString(), 'blok': (blok).toString()});
                                                  Map<String, dynamic> parsed = jsonDecode(response.body);
                                                  Alert(
                                                    context: context,
                                                    type: parsed["success"] ? AlertType.success : AlertType.error,
                                                    title: parsed["success"] ? parsed["pesan"] : "Booking Failed!",
                                                    desc: parsed["success"] ? '' : parsed["pesan"],
                                                    buttons: [
                                                      DialogButton(
                                                          child: Text(
                                                            "OK",
                                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                                          ),
                                                          onPressed: () {
                                                            Phoenix.rebirth(context);
                                                          })
                                                    ],
                                                  ).show();
                                                },
                                            )
                                        ],
                                    );
                                      },
                                    );
                                  })
                                // Alert(
                                //     context: context,
                                //     type: AlertType.info,
                                //     desc: "ingin memesan tempat ini ?",
                                //     buttons: [
                                //       DialogButton(
                                //         child: Text(
                                //           "Yes",
                                //           style: TextStyle(color: Colors.white, fontSize: 18),
                                //         ),
                                //         onPressed: () async {
                                //           var url = Uri.parse(globals.api + '/order');
                                //           final response = await http.post(url, body: {'mall_id': (mall.id).toString(), 'user_id': (globals.user_id).toString()});
                                //           Map<String, dynamic> parsed = jsonDecode(response.body);
                                //           Alert(
                                //             context: context,
                                //             type: parsed["success"] ? AlertType.success : AlertType.error,
                                //             title: parsed["success"] ? parsed["pesan"] : "Booking Failed!",
                                //             desc: parsed["success"] ? '' : parsed["pesan"],
                                //             buttons: [
                                //               DialogButton(
                                //                   child: Text(
                                //                     "OK",
                                //                     style: TextStyle(color: Colors.white, fontSize: 20),
                                //                   ),
                                //                   onPressed: () {
                                //                     Phoenix.rebirth(context);
                                //                   })
                                //             ],
                                //           ).show();
                                //         },
                                //         color: Color.fromRGBO(0, 179, 134, 1.0),
                                //       ),
                                //       DialogButton(
                                //         child: Text(
                                //           "No",
                                //           style: TextStyle(color: Colors.white, fontSize: 18),
                                //         ),
                                //         onPressed: () => Navigator.pop(context),
                                //         gradient: LinearGradient(colors: [
                                //           Color.fromRGBO(116, 116, 191, 1.0),
                                //           Color.fromRGBO(52, 138, 199, 1.0),
                                //         ]),
                                //       )
                                //     ],
                                //   ).show()
                                : Alert(
                                    context: context,
                                    type: AlertType.error,
                                    desc: "Maaf,\nMall ini Penuh :(",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ).show();
                          },
                          child: Text(
                            "Booking",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 40),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),

          // Positioned(
          //     right: 5.0,
          //     bottom: 20.0,
          //     child: Column(
          //     children: [
          //       Container(
          //           child: SizedBox(
          //             width: MediaQuery.of(context).size.width / 4,
          //             height: 28.0,
          //             child: Align(
          //               alignment: Alignment.bottomRight,
          //               child: ElevatedButton(
          //                 onPressed: () {
          //                   mall.orderCount! < mall.kuotaMall
          //                       ? Alert(
          //                           context: context,
          //                           type: AlertType.info,
          //                           desc: "ingin memesan tempat ini ?",
          //                           buttons: [
          //                             DialogButton(
          //                               child: Text(
          //                                 "Yes",
          //                                 style: TextStyle(color: Colors.white, fontSize: 18),
          //                               ),
          //                               onPressed: () async {
          //                                 var url = Uri.parse(globals.api + '/order');
          //                                 final response = await http.post(url, body: {'mall_id': (mall.id).toString(), 'user_id': (globals.user_id).toString()});
          //                                 Map<String, dynamic> parsed = jsonDecode(response.body);
          //                                 Alert(
          //                                   context: context,
          //                                   type: parsed["success"] ? AlertType.success : AlertType.error,
          //                                   title: parsed["success"] ? parsed["pesan"] : "Booking Failed!",
          //                                   desc: parsed["success"] ? '' : parsed["pesan"],
          //                                   buttons: [
          //                                     DialogButton(
          //                                         child: Text(
          //                                           "OK",
          //                                           style: TextStyle(color: Colors.white, fontSize: 20),
          //                                         ),
          //                                         onPressed: () {
          //                                           Phoenix.rebirth(context);
          //                                         })
          //                                   ],
          //                                 ).show();
          //                               },
          //                               color: Color.fromRGBO(0, 179, 134, 1.0),
          //                             ),
          //                             DialogButton(
          //                               child: Text(
          //                                 "No",
          //                                 style: TextStyle(color: Colors.white, fontSize: 18),
          //                               ),
          //                               onPressed: () => Navigator.pop(context),
          //                               gradient: LinearGradient(colors: [
          //                                 Color.fromRGBO(116, 116, 191, 1.0),
          //                                 Color.fromRGBO(52, 138, 199, 1.0),
          //                               ]),
          //                             )
          //                           ],
          //                         ).show()
          //                       : Alert(
          //                           context: context,
          //                           type: AlertType.error,
          //                           desc: "Maaf,\nMall ini Penuh :(",
          //                           buttons: [
          //                             DialogButton(
          //                               child: Text(
          //                                 "OK",
          //                                 style: TextStyle(color: Colors.white, fontSize: 18),
          //                               ),
          //                               onPressed: () => Navigator.pop(context),
          //                             ),
          //                           ],
          //                         ).show();
          //                 },
          //                 child: Text(
          //                   "Booking",
          //                   style: TextStyle(fontSize: MediaQuery.of(context).size.width / 40),
          //                 ),
          //               ),
          //             ),
          //           )),
          //     ],
          //   ),
          // ),
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
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 10.0,
        //     offset: Offset(0.0, 10.0),
        //   ),
        // ],
      ),
    );


    return Container(
      height: 150.0,
      margin: const EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
      child: Stack(
        children: <Widget>[
          cardCard,
          cardThumbnail,
        ],
      ),
    );
  }
}
