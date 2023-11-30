import 'package:flutter/material.dart';
import 'package:travel_booking_flutter_v2/Screens/CommunityScreen.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.blue,
  padding: EdgeInsets.all(8.0),
);
class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('THANH TOÁN QUA ỨNG DỤNG MOMO'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextButton(

                child: Text('DEMO PAYMENT WITH MOMO.VN'),
                onPressed: () async {
                },
              ),
              Text(  "CHƯA THANH TOÁN")
            ],
          ),
        ),
      ),
    );
  }

}


