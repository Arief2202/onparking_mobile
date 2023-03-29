// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:onparking_mobile/api/api.dart';
import 'package:onparking_mobile/model/mallList.dart';
import 'package:onparking_mobile/listItemAdmin.dart';
import 'package:onparking_mobile/GradientAppBar.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Dashboard_Admin extends StatefulWidget {
  const Dashboard_Admin({
    Key? key,
  }) : super(key: key);
  @override
  _Dashboard_AdminState createState() => _Dashboard_AdminState();
}

class _Dashboard_AdminState extends State<Dashboard_Admin> {
  late Future<MallListResult> _mall;
  @override
  void initState() {
    super.initState();
    _mall = ApiService().readMall();
  }

  Widget _buildList(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
      // margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 50.0),
      // padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [
          // 0.1,
          0.1,
          0.6,
          0.9,
        ],
        colors: [
          // Colors.yellow,
          // Colors.red,
          Color.fromARGB(255, 5, 54, 145),
          Color.fromARGB(255, 158, 158, 158),
          Color.fromARGB(255, 32, 25, 100),
        ],
      )),
      child: Column(
        children: [
          GradientAppBar(),
          Container(
            // margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 80,
            child: FutureBuilder(
              future: _mall,
              builder: (context, AsyncSnapshot<MallListResult> snapshot) {
                var state = snapshot.connectionState;
                if (state != ConnectionState.done) {
                  context.loaderOverlay.show();
                  return Center();
                  // return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    context.loaderOverlay.hide();
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.MallLists.length,
                      itemBuilder: (context, index) {
                        var mall = snapshot.data?.MallLists[index];
                        return InkWell(
                          onTap: () async {},
                          child: ListItemAdmin(mall: mall!),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return Text('');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _Dashboard_AdminState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: _buildList(context),
      ),
    );
  }
}
