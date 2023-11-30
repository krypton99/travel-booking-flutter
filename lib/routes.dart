import 'package:flutter/widgets.dart';
import 'package:travel_booking_flutter_v2/Screens/AccountScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/CommentScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/CommunityScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/DetailedTourScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/FavouriteScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/HistoryScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/HomeScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/LoginScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/PaymentScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/ProfileScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/SearchScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/SignUpScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/TourBookingScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/TourListScreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/": (context) =>HomeScreen(),
    "/account": (context) =>AccountScreen(),
    "/comment": (context) =>CommentScreen(2),
    "/community": (context) =>CommunityScreen(),
    "/detailed-tour-screen": (context) =>DetailedTourScreen(1),
    "/favourite": (context) =>FavouriteScreen(),
    "/history": (context) =>HistoryScreen(),
    "/home": (context) =>HomeScreen(),
    "/login": (context) =>LoginScreen(),
    "/payment": (context) =>PaymentScreen(),
    "/profile": (context) =>ProfileScreen(),
    "/search": (context) =>SearchScreen(),
    "/sign-up": (context) =>SignUpScreen(),
    // "/tour-booking": (context) =>TourBookingScreen(),
    // "/tour-list": (context) =>TourListScreen(),
};
