// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, sort_child_properties_last, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unnecessary_new, unnecessary_string_escapes, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:onparking_mobile/api/api.dart';
import 'package:onparking_mobile/model/orderList.dart';
import 'package:onparking_mobile/orderListView.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    return FutureBuilder(
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
    );
  }

  _StatusPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
