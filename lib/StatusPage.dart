// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, sort_child_properties_last, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unnecessary_new, unnecessary_string_escapes, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:onparking_mobile/api/api.dart';
import 'package:onparking_mobile/model/orderList.dart';
import 'package:onparking_mobile/orderListView.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onparking_mobile/GradientAppBar.dart';

class StatusPage extends StatefulWidget {
  // final List<MallList> doneTourismPlaceList;
  const StatusPage({
    Key? key,
    // required this.doneTourismPlaceList
  }) : super(key: key);
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  // final List<TourismPlace> doneTourismPlaceList;
  late Future<OrderListResult> _mall;
  @override
  void initState() {
    super.initState();
    _mall = ApiService().readOrder(context);
  }

  Widget _buildList(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      // height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
      // margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 50.0),
      // padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        // stops: [
        //   // 1,
        //   0.1,
        //   0.6,
        //   0.9,
        // ],
        colors: [
          // Colors.white,
          Color.fromARGB(255, 68, 38, 145),
          Color.fromARGB(255, 31, 92, 116),
          // Color.fromARGB(255, 3, 73, 202),
          // Color.fromARGB(255, 97, 106, 145),
          // Color.fromARGB(255, 32, 25, 100),
        ],
      )),
      child: Column(
        children: [
          // GradientAppBar(),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 80,
            child: FutureBuilder(
      future: _mall,
      builder: (context, AsyncSnapshot<OrderListResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          context.loaderOverlay.show();
          return Center();
          // return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            context.loaderOverlay.hide();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.orders.length,
              itemBuilder: (context, index) {
                var OrderList = snapshot.data?.orders[index];
                return InkWell(
                  child: OrderListView(orderList: OrderList!),
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
    ))]));
  }

  _StatusPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 44, 138),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Phoenix.rebirth(context),
        ),
        title: Text("Status Pemesanan"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return StatusPage();
                  }),
                );
              })
        ],
      ),
      body: _buildList(context),
    );
  }
}
