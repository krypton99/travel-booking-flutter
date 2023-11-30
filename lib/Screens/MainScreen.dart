import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_booking_flutter_v2/Models/LoginResponse.dart';
import 'package:travel_booking_flutter_v2/Screens/AccountScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/CommunityScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/HistoryScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/HomeScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/PostScreen.dart';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
import 'TourListScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  int _lastSelectedIndex = -1;
  final LoginResponse? loginResponse;

  _MainScreenState( {this.loginResponse});
  void _onItemTapped(int index) {
    if (index != _lastSelectedIndex) {
      setState(() {
        globals.isCommunity=false;
        _selectedIndex = index;
        _lastSelectedIndex = _selectedIndex;
        // if (_selectedIndex != _lastSelectedIndex) {
        //   _navigatorKey.currentState.pushReplacementNamed("/${index}");
        //   _lastSelectedIndex = _selectedIndex;
        // }
      });
    }
  }

  Widget _MyNavigator() {
    Scaffold scaffold = new Scaffold();
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return CommunityScreen();
      // case 2:
      //   return HistoryScreen();
      case 2:
        return AccountScreen();
        break;
      default:
        return HomeScreen();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(globals.isCommunity)
      _selectedIndex=1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MyNavigator(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          // Respond to item press.
          _onItemTapped(value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Trang chủ',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Cộng đồng',
            icon: Icon(Icons.public),
          ),
          // BottomNavigationBarItem(
          //   title: Text('Lịch sử'),
          //   icon: Icon(Icons.favorite),
          // ),
          BottomNavigationBarItem(
            label: 'Tài khoản',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
