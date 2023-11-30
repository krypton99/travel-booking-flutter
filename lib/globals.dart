library my_prj.globals;

import 'package:travel_booking_flutter_v2/Models/LoginResponse.dart';

import 'Models/Order.dart';
import 'Models/Post.dart';
import 'Models/Tour.dart';

bool isLoggedIn = false;
bool isCommunity = false;
LoginResponse? loginResponse;// TODO Implement this library.
List<Tour>? tours;
Future<dynamic>? futureTour;
List<Post>? posts;
Future<dynamic>? futurePost;
List<OrderResponse>? orders;
Future<dynamic>? futureOrder;


