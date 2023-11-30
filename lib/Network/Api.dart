import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_booking_flutter_v2/Models/Exception.dart';
import 'package:travel_booking_flutter_v2/Models/LoginRequest.dart';
import 'package:travel_booking_flutter_v2/Models/LoginResponse.dart';
import 'package:travel_booking_flutter_v2/Models/Order.dart';
import 'package:travel_booking_flutter_v2/Models/Post.dart';
import 'package:travel_booking_flutter_v2/Models/PostRequest.dart';
import 'package:travel_booking_flutter_v2/Models/SearchRequest.dart';
import 'package:travel_booking_flutter_v2/Models/Tour.dart';
import 'package:http/http.dart' as http;
import 'package:travel_booking_flutter_v2/Models/User.dart';
import 'dart:convert';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
import 'package:travel_booking_flutter_v2/Screens/TourListScreen.dart';
class Api {
  static const String _baseUrl = "http://192.168.1.13:8080/";

  static Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await http.post(
        Uri.parse('${_baseUrl}api/public/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginRequest.toJson()),
    );
    log('response status' + response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return LoginResponse.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<List<Tour>> search(SearchRequest searchRequest) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}api/public/tour/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(searchRequest.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (json.decode(utf8.decode(response.bodyBytes)) as List)
          .map((p) => Tour.fromJson(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<List<Tour>> getTour() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${_baseUrl}api/public/tour/'));
    if (response.statusCode == 200) {
      return (json.decode(utf8.decode(response.bodyBytes)) as List)
          .map((p) => Tour.fromJson(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<Tour> fetchTour(int id) async {
    http.Response response;
    response = await http
        .get(Uri.parse('${_baseUrl}api/public/tour/$id'));
    if (response.statusCode == 200) {
      return Tour.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<dynamic> signUp(User user) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}api/public/auth/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<bool> order(Contact contact) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}api/public/order/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 200) {

      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<List<OrderResponse>> getOrder() async {
    http.Response response;
    response= await http.get(
      Uri.parse('${_baseUrl}api/user/tour/get-orders/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Bearer ${globals.loginResponse?.token}",
      },
    );
    if(response.statusCode==200){
      return (json.decode(utf8.decode(response.bodyBytes)) as List).map((p) =>
          OrderResponse.fromJson(p)).toList();

    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(CustomException
          .fromJson(json.decode(utf8.decode(response.bodyBytes)))
          .message);
    }
  }


  static Future<dynamic> getPosts() async {
    http.Response response;
    response= await http.get(Uri.parse('${_baseUrl}api/public/posts/'));
    if(response.statusCode==200){

      return (json.decode(utf8.decode(response.bodyBytes)) as List).map((p) =>
          Post.fromJson(p)).toList();

    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(CustomException
          .fromJson(json.decode(utf8.decode(response.bodyBytes)))
          .message);
    }
  }
  static Future<Post> getPost(int id) async {
    http.Response response;
    response= await http.get(Uri.parse('${_baseUrl}api/public/posts/$id'));
    if(response.statusCode==200){

      return Post.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(CustomException
          .fromJson(json.decode(utf8.decode(response.bodyBytes)))
          .message);
    }
  }
  static Future post(PostRequest postRequest) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}api/user/posts/create'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Bearer ${globals.loginResponse?.token}",
      },
      body: jsonEncode(postRequest.toJson()),
    );
    print("${jsonEncode(postRequest.toJson())}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("Response status: ${response.statusCode}");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Response status: ${response.statusCode}");
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }
}
