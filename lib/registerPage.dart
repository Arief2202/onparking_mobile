// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, sort_child_properties_last, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unnecessary_new, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:onparking_mobile/globals.dart' as globals;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  @override
  RegisterPageState createState() {
    return new RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  List<TextEditingController> _data = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
  List<bool> _error = [false, false, false, false, false];
  String _passwordMsg = "Value Can\'t Be Empty";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/img/logo.png',
                    width: MediaQuery.of(context).size.width,
                  ),
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
                      labelText: 'Nama',
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
                      labelText: 'ID Kartu',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
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
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
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
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: 20),
                      errorText: _error[3] ? _passwordMsg : null,
                    ),
                    controller: _data[3],
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
                  _doRegister(context);
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
            SizedBox(height: MediaQuery.of(context).size.width / 15),
          ],
        ),
      ),
    );
  }

  Future _doRegister(context) async {
    bool status = true;
    setState(() {
      _passwordMsg = "Value Can\'t Be Empty";
      for (int a = 0; a < 5; a++) {
        if (_data[a].text.isEmpty) {
          _error[a] = true;
          status = false;
        } else
          _error[a] = false;
      }
    });
    if (status && (_data[2].text != _data[3].text)) {
      setState(() {
        status = false;
        _error[3] = true;
        _passwordMsg = "Password not same!";
      });
    }
    if (status) {
      String _name = _data[0].text;
      String _email = _data[1].text;
      String _password = _data[2].text;
      String _card = _data[4].text;
      // context.loaderOverlay.show();
      var url = Uri.parse(globals.api + '/register');
      // var response = await http.post(url, body: {});
      final response = await http.post(url, body: {'name': _name, 'email': _email, 'password': _password, 'card_id': _card});
      // context.loaderOverlay.hide();

      if (response.statusCode == 200) {
        Map<String, dynamic> parsed = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', (parsed['data']['user']['id']).toString());
        await prefs.setString('user_role', parsed['data']['user']['role']);
        await prefs.setString('user_name', parsed['data']['user']['name']);
        await prefs.setString('user_email', parsed['data']['user']['email']);
        await prefs.setString('user_password', parsed['data']['user']['password']);
        await prefs.setString('user_card_id', parsed['data']['user']['card_id']);
        setState(() {
          globals.user_id = (parsed['data']['user']['id']).toString();
          globals.user_role = parsed['data']['user']['role'];
          globals.user_name = parsed['data']['user']['name'];
          globals.user_email = parsed['data']['user']['email'];
          globals.user_password = parsed['data']['user']['password'];
          globals.user_card_id = parsed['data']['user']['card_id'];
          globals.isLoggedIn = true;
        });
        Alert(
          context: context,
          type: AlertType.info,
          desc: "Register Success",
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
          title: "Register Failed!",
          desc: "Internal Server Error\n" + globals.api + '/register',
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
