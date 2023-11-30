import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_booking_flutter_v2/Models/LoginResponse.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/FavouriteScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/HomeScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/MainScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/TourBookingScreen.dart';
import 'package:travel_booking_flutter_v2/main.dart';

import 'SearchScreen.dart';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_SplashSate();
}

class _SplashSate extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globals.futurePost=  Api.getPosts().then((value) {
      setState(() {
        globals.posts=value;
      });
    });
    globals.futureTour = Api.getTour().then((value) {
      setState(() {
        globals.tours = value;
      });
    });
    Timer(Duration(seconds: 3), ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen())));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child:
            Image.asset('images/logo.png', height: 300, fit: BoxFit.fitHeight),
      ),
    );
  }
}
