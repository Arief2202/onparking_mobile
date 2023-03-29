// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:onparking_mobile/StatusPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:onparking_mobile/addMall.dart';
import 'package:onparking_mobile/globals.dart' as globals;

class GradientAppBar extends StatefulWidget {
  // final List<MallList> doneTourismPlaceList;
  const GradientAppBar({
    Key? key,
    // required this.doneTourismPlaceList
  }) : super(key: key);
  @override
  _GradientAppBar createState() => _GradientAppBar();
}

class _GradientAppBar extends State<GradientAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width-20,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 27, 56),
                Color.fromARGB(255, 0, 46, 87),
              ],
              begin: const FractionalOffset(
                0.0,
                0.0,
              ),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.1, 0.8],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/img/logo_white.png",
                    width: MediaQuery.of(context).size.width / 3,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 30),
              child: Row(
                children: [
                  if (globals.user_role == "1")
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AddMall();
                                }),
                              );
                            },
                            child: Image.asset('assets/img/add_white.png', height: MediaQuery.of(context).size.width / 17),
                          ),
                        ),
                      ],
                    ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        child: InkWell(
                          onTap: () {
                            Phoenix.rebirth(context);
                          },
                          child: Image.asset('assets/img/refresh_white.png', height: MediaQuery.of(context).size.width / 17),
                        ),
                      ),
                    ],
                  ),
                  if (globals.user_role == "0")
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return StatusPage();
                                }),
                              );
                            },
                            child: Image.asset('assets/img/notif_white.png', height: MediaQuery.of(context).size.width / 17),
                          ),
                        ),
                      ],
                    ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        child: InkWell(
                          onTap: () async {
                            Alert(
                              context: context,
                              type: AlertType.info,
                              desc: "Do you want to Logout ?",
                              buttons: [
                                DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      // Navigator.pop(context);
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.remove('user_id');
                                      await prefs.remove('user_role');
                                      await prefs.remove('user_name');
                                      await prefs.remove('user_email');
                                      await prefs.remove('user_password');
                                      await prefs.remove('user_card_id');

                                      setState(() {
                                        globals.user_id = "";
                                        globals.user_name = "";
                                        globals.user_email = "";
                                        globals.user_password = "";
                                        globals.user_card_id = "";
                                        globals.isLoggedIn = false;
                                      });
                                      // Navigator.pop(context);
                                      Phoenix.rebirth(context);
                                    }),
                                DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Phoenix.rebirth(context);
                                    })
                              ],
                            ).show();
                          },
                          child: Image.asset('assets/img/logout_white.png', height: MediaQuery.of(context).size.width / 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
