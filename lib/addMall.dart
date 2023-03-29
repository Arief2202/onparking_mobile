// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, sort_child_properties_last, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unnecessary_new, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:onparking_mobile/globals.dart' as globals;

class AddMall extends StatefulWidget {
  AddMall({Key? key}) : super(key: key);
  @override
  AddMallState createState() {
    return new AddMallState();
  }
}

class AddMallState extends State<AddMall> {
  List<TextEditingController> _data = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
  List<bool> _error = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Phoenix.rebirth(context),
        ),
        title: Text("Tambahkan Mall"),
      ),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // Container(
            //   margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
            //   child: Column(
            //     children: <Widget>[
            //       Image.asset(
            //         'assets/img/logo.png',
            //         width: MediaQuery.of(context).size.width / 2,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Link Foto Mall',
                      labelStyle: TextStyle(fontSize: 20),
                      errorText: _error[0] ? 'Value Can\'t Be Empty' : null,
                    ),
                    controller: _data[0],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nama Mall',
                      labelStyle: TextStyle(fontSize: 20),
                      errorText: _error[1] ? 'Value Can\'t Be Empty' : null,
                    ),
                    controller: _data[1],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alamat Mall',
                      labelStyle: TextStyle(fontSize: 20),
                      errorText: _error[2] ? 'Value Can\'t Be Empty' : null,
                    ),
                    controller: _data[2],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Open Time (ex. 08:00-20:00)',
                      labelStyle: TextStyle(fontSize: 20),
                      errorText: _error[3] ? 'Value Can\'t Be Empty' : null,
                    ),
                    controller: _data[3],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kuota Mall',
                      labelStyle: TextStyle(fontSize: 20),
                      errorText: _error[4] ? 'Value Can\'t Be Empty' : null,
                    ),
                    controller: _data[4],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 10,
              child: ElevatedButton(
                onPressed: () {
                  _doAddMall(context);
                },
                child: Text(
                  "Tambahkan Mall",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _doAddMall(context) async {
    bool status = true;
    setState(() {
      for (int a = 0; a < 5; a++) {
        if (_data[a].text.isEmpty) {
          _error[a] = true;
          status = false;
        } else
          _error[a] = false;
      }
    });
    if (status) {
      String _fotoMall = _data[0].text;
      String _namaMall = _data[1].text;
      String _alamatMall = _data[2].text;
      String _openTimeMall = _data[2].text;
      String _kuotaMall = _data[4].text;
      // context.loaderOverlay.show();
      var url = Uri.parse(globals.api + '/createMall');
      // var response = await http.post(url, body: {});
      final response = await http.post(url, body: {'email': globals.user_email, 'password': globals.user_password, 'fotoMall': _fotoMall, 'namaMall': _namaMall, 'alamatMall': _alamatMall, 'openTimeMall': _openTimeMall, 'kuotaMall': _kuotaMall});
      // context.loaderOverlay.hide();

      if (response.statusCode == 200) {
        Map<String, dynamic> parsed = jsonDecode(response.body);
        Alert(
          context: context,
          type: AlertType.info,
          desc: parsed['pesan'],
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Phoenix.rebirth(context),
            )
          ],
        ).show();
        // var count = 0;
        // Navigator.popUntil(context, (route) {
        //   return count++ == 1;
        // });
      } else if (response.statusCode == 400) {
        Map<String, dynamic> parsed = jsonDecode(response.body);
        Alert(
          context: context,
          type: AlertType.info,
          title: "Register Failed!",
          desc: parsed["pesan"],
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ).show();
        // throw Exception('Failed to load top headlines');
      } else {
        Alert(
          context: context,
          type: AlertType.info,
          title: "Register Failed! (" + response.statusCode.toString() + ")",
          desc: "Internal Server Error\n" + globals.api + '/createMall',
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ).show();
      }
    }
  }
}
