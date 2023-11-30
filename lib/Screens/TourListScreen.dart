import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:travel_booking_flutter_v2/Models/SearchRequest.dart';
import 'package:travel_booking_flutter_v2/Models/Tour.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/DetailedTourScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/SearchScreen.dart';
import 'dart:math' as math;
import '../Utils/Constants.dart';
import 'package:http/http.dart' as http;

class Trip {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final String travelType;
  final String imgUrl;

  Trip(this.title, this.startDate, this.endDate, this.budget, this.travelType,
      this.imgUrl);
}

class TourListScreen extends StatefulWidget {
  final String searchKey;

  TourListScreen(@required this.searchKey);

  @override
  _TourListScreenState createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  Future<List<Tour>>? _futureResponse;
  Future<dynamic>? _future;
  List<Tour>? Tours;

  Tour? tour;

  void search(String searchKey) {
    SearchRequest searchRequest = new SearchRequest(endPlace: searchKey, endTime: "", name: "", national: "", province: "", startPlace: "",startTime: "", time: "");
    Api.search(searchRequest).then((tour) {
      setState(() {
        Tours = tour;
      });
    });
    //   dialogContent(context, e.toString().substring(11));
  }

  @override
  void initState() {
    super.initState();

    search(widget.searchKey);
  }

  static List getDummyList(int length) {
    List list = List.generate(length, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List items = getDummyList(Tours == null ? 0 : Tours!.length);
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Bạn cần tìm gì",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchScreen(),
                          ),
                        );
                      },
                    )),
                Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ))
              ],
            )),
        backgroundColor: Colors.orange,
      ),
      body: Container(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => buildTripCard(context, index))),
    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final Tour tour = Tours![index];
    final oCcy = new NumberFormat("#,### đ", "en_US");
    return new Container(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailedTourScreen(Tours![index].id),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Wrap(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(tour == null
                            ? 'Loading...'
                            : tour.imageEntities[0].image),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder()),
                  width: double.maxFinite,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 4.0, left: 20.0, right: 20.0),
                  child: AutoSizeText(
                    tour == null ? 'Loading...' : tour.name,
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 7.0, bottom: 5.0, left: 20.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 15.0,
                      color: Colors.orangeAccent,
                    ),
                    Text(
                      "5.0",
                      style: new TextStyle(
                          fontSize: 15.0, color: Colors.orangeAccent),
                    ),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(children: <Widget>[
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${oCcy.format(tour == null ? 'Loading...' : tour.priceEntities[0].price)}",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      Spacer(),
                      Icon(Icons.event_available,
                          size: 15.0, color: Colors.green),
                      Text(
                        "Có thể đặt từ hôm nay",
                        style:
                            new TextStyle(fontSize: 10.0, color: Colors.green),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        margin: const EdgeInsets.all(20.0),
      ),
    );
  }
}
