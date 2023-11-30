import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:travel_booking_flutter_v2/Models/Tour.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/DetailedTourScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/SearchScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/TourBookingScreen.dart';
import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import '../Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:travel_booking_flutter_v2/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Color(0xFF162A49),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  iconColor: Colors.white,

);
class _HomeScreenState extends State<HomeScreen> {
  List? listresponse;
  List<Tour>? Tours;
  Tour? tour;

  late PageController _pageController;
  int _page = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    globals.futureTour = Api.getTour().then((value) {
      setState(() {
        globals.tours = value;
       // Tours=globals.tours!;
      });
    });
    log('data: $Tours');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              //color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Bạn đang tìm gì",
                        hintStyle: TextStyle(color: Colors.white),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)
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
      body: Stack(
        children: <Widget>[
          Text(
            listresponse.toString(),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  child: ImageCarousel(),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment(-0.8, -0.5),
                  child: new Text("TOUR HOT",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                SizedBox(height: 8),
                Container(
                  height: 400,
                  child: Align(
                    child: globals.tours != null
                        ? SlidingCardsView(globals.tours!)
                        : Center(child: CircularProgressIndicator()),
                    // child: FutureBuilder(
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.none &&
                    //         snapshot.hasData == null) {
                    //       //print('project snapshot data is: ${projectSnap.data}');
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //     return snapshot.hasData?
                    //     SlidingCardsView(snapshot.data):Center(child: CircularProgressIndicator());
                    //   },
                    //   future: globals.futureTour,
                    // ),
                    alignment: Alignment.center,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlidingCardsView extends StatefulWidget {
  final List<Tour> Tours;

  SlidingCardsView(@required this.Tours);

  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[0].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[0].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[0].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[0].priceEntities[0].price,
            id: widget.Tours == null ? 0 : widget.Tours[0].id,
            offset: pageOffset,
          ),
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[1].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[1].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[1].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[1].priceEntities[0].price,
            offset: pageOffset - 1,
            id: widget.Tours == null ? 0 : widget.Tours[1].id,
          ),
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[2].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[2].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[2].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[2].priceEntities[0].price,
            offset: pageOffset - 2,
            id: widget.Tours == null ? 0 : widget.Tours[2].id,
          ),
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[3].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[3].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[3].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[3].priceEntities[0].price,
            offset: pageOffset - 3,
            id: widget.Tours == null ? 0 : widget.Tours[3].id,
          ),
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[4].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[4].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[4].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[4].priceEntities[0].price,
            offset: pageOffset - 4,
            id: widget.Tours == null ? 0 : widget.Tours[4].id,
          ),
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[5].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[5].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[5].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[5].priceEntities[0].price,
            offset: pageOffset - 5,
            id: widget.Tours == null ? 0 : widget.Tours[5].id,
          ),
          SlidingCard(
            name: widget.Tours == null ? 'Loading...' : widget.Tours[6].name,
            date: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[6].startTime.substring(0, 10),
            assetName: widget.Tours == null
                ? 'Loading...'
                : widget.Tours[6].avatarTour,
            price: widget.Tours == null
                ? 0
                : widget.Tours[6].priceEntities[0].price,
            offset: pageOffset - 6,
            id: widget.Tours == null ? 0 : widget.Tours[6].id,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;
  final int price;
  final int id;

  const SlidingCard({
    Key? key,
    required this.name,
    required this.date,
    required this.assetName,
    required this.offset,
    required this.price,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 15),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.network(
                '$assetName',
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                price: price,
                id: id,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;
  final int price;
  final int? id;
  final oCcy = new NumberFormat("#,### đ", "en_US");

  CardContent(
      {Key? key,
      required this.name,
      required this.date,
      required this.offset,
      required this.price,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailedTourScreen(id ?? 0),
                      ),
                    );
                  },
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Đặt ngay'),
                  ),
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Text(
                  '${oCcy.format(price)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  _ImageCarouselState createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List imageList = [
      {"id": 1, "image_path": 'images/01.jpg'},
      {"id": 2, "image_path": 'images/02.jpg'},
    ];
    int currentIndex = 0;
    final CarouselController carouselController = CarouselController();
    Widget carousel = new CarouselSlider(
      items: imageList
          .map(
            (item) => Image.asset(
          item['image_path'],
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      )
          .toList(),
      carouselController: carouselController,
      options: CarouselOptions(
        scrollPhysics: const BouncingScrollPhysics(),
        autoPlay: true,
        aspectRatio: 2,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );

    Widget banner = new Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          color: Colors.amber.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          'Banner on top of carousel',
          style: TextStyle(
            fontFamily: 'fira',
            fontSize: animation.value, //18.0,
            //color: Colors.white,
          ),
        ),
      ),
      // ),
      //  ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          height: screenHeight / 2,
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: new Stack(
              children: [
                carousel,
                banner,
              ],
            ),
          ),
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
