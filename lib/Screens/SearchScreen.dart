import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

import 'package:travel_booking_flutter_v2/Screens/TourListScreen.dart';
class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PageController? _pageController;
  int _page = 0;
  int _selectedIndex = 0;
  GlobalKey<ScaffoldMessengerState>? _key;
  List<String>? _dynamicChips;
  bool? _isSelected;
  List<Location>? _locations;
  List<String>? _filters;
  List<String>? _choices;
  int? _defaultChoiceIndex;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldMessengerState>();
    _isSelected = false;
    _defaultChoiceIndex = 0;
    _filters = <String>[];
    _locations = <Location>[
      const Location('Vũng Tàu'),
      const Location('Hạ Long'),
      const Location('Nha Trang'),
      const Location('Phú Quốc'),
      const Location('Bình Định'),
    ];
    _dynamicChips = ['Health', 'Food', 'Nature'];
    _choices = ['Choice 1', 'Choice 2', 'Choice 3'];

  }
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final _controller = TextEditingController();
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Địa điểm muốn khám phá",
                        hintStyle: TextStyle(color: Colors.white),
                      ),

                    )
                ),
                Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TourListScreen(_controller.text),
                        ),
                      );},
                      icon: Icon(Icons.search, color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    )
                )
              ],
            )
        ),
        backgroundColor: Colors.orange,

      ),

      body: Column(
        children: <Widget>[
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
           ),
          Divider(),
          Align(
            alignment: Alignment(-0.9, -0.5),
            child: new Text(
                "Xu hướng tìm kiếm",
                style:TextStyle(color: Colors.orange, fontSize: 15.0,fontWeight: FontWeight.bold),
                textAlign: TextAlign.left
            ),
          ),
          Wrap(
            children: locationWidgets.toList(),
          ),
          Align(
            alignment: Alignment(-0.9, -0.5),
            child: new Text(
                "Tìm kiếm theo địa điểm",
                style:TextStyle(color: Colors.orange, fontSize: 15.0,fontWeight: FontWeight.bold),
                textAlign: TextAlign.left
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.only(left: 13.0),
              child: Wrap(
                children: locationWidgets.toList(),
              ),
            )


          ),

        ],
      ),
    );
  }
  rowChips() {
    return Row(
      children: <Widget>[
        chipForRow('Health', Color(0xFFff8a65)),
        chipForRow('Food', Color(0xFF4fc3f7)),
        chipForRow('Lifestyle', Color(0xFF9575cd)),
        chipForRow('Sports', Color(0xFF4db6ac)),
        chipForRow('Nature', Color(0xFF5cda65)),
      ],
    );
  }

  wrapWidget() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        chip('Health', Color(0xFFc40233)),
        chip('Food', Color(0xFF007f5c)),
        chip('Lifestyle', Color(0xFF5f65d3)),
        chip('Sports', Color(0xFF19ca21)),
        chip('Nature', Color(0xFF60230b)),
      ],
    );
  }

  dynamicChips() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(_dynamicChips!.length, (int index) {
        return Chip(
          label: Text(_dynamicChips![index]),
          onDeleted: () {
            setState(() {
              _dynamicChips!.removeAt(index);
            });
          },
        );
      }),
    );
  }

  Widget choiceChips() {
    return Expanded(
      child: ListView.builder(
        itemCount: _choices!.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(_choices![index]),
            selected: _defaultChoiceIndex == index,
            selectedColor: Colors.green,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceIndex = selected ? index : 0;
              });
            },
            backgroundColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  Widget inputChips() {
    return InputChip(
      padding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade600,
        child: Text('JW'),
      ),
      label: Text('James Watson'),
      selected: _isSelected!,
      selectedColor: Colors.green,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
      // onPressed: () {
      //   //
      // },
      onDeleted: () {
        //
      },
    );
  }

  Widget actionChips() {
    return ActionChip(
      elevation: 6.0,
      padding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.green[60],
        child: Icon(Icons.call),
      ),
      label: Text('Call'),
      onPressed: () {
        _key!.currentState!.showSnackBar(SnackBar(
          content: Text('Calling...'),
        ));
      },
      backgroundColor: Colors.white,
      shape: StadiumBorder(
          side: BorderSide(
            width: 1,
            color: Colors.blueAccent,
          )),
    );
  }

  Iterable<Widget> get locationWidgets sync* {
    List colors = [Colors.red, Colors.green, Colors.yellow];
    Random random = new Random();

    for (Location location in _locations!) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.white60,
          shape: StadiumBorder(side: BorderSide(width:0.5)),
          label: Text(location.name),
          selected: _filters!.contains(location.name),
          selectedColor: Colors.orangeAccent,
          showCheckmark: false,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters!.add(location.name);
                _controller.text = _filters!.join(', ');
              } else {
                _filters!.removeWhere((String name) {
                  return name == location.name;
                });
                _controller.text=_filters!.join(', ');
              }
            });
          },
        ),
      );
    }
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  Widget chipForRow(String label, Color color) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade600,
          child: Text(label[0].toUpperCase()),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }
}

class Location {
  const Location(this.name);
  final String name;
}

