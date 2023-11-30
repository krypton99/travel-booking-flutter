import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Image.dart';
import 'Price.dart';
import 'Schedule.dart';
class Tour {
  final int id;
  final String name;
  final String codeTour;
  final String startPlace;
  final String endPlace;
  final String province;
  final String national;
  final String startTime;
  final String endTime;
  final String time;
  final String status;
  final String description;
  final String avatarTour;
  final int discountPercent;
  final List<PriceEntities> priceEntities;
  final List<ScheduleEntities> scheduleEntities;
  final List<ImageEntities> imageEntities;

  Tour({required this.id,
    required this.name,
    required this.codeTour,
    required this.startPlace,
    required this.endPlace,
    required this.province,
    required this.national,
    required this.startTime,
    required this.endTime,
    required this.time,
    required this.status,
    required this.description,
    required this.avatarTour,
    required this.discountPercent,
    required this.priceEntities,
    required this.imageEntities,
    required this.scheduleEntities});

  factory Tour.fromJson(Map<String, dynamic> json) {
    List<dynamic> priceEntities = json['priceEntities'];
    List<PriceEntities> priceentities=priceEntities.map((p)=>PriceEntities.fromJson(p)).toList();
    List<dynamic> scheduleEntities = json['scheduleEntities'];
    List<ScheduleEntities> scheduleentities=scheduleEntities.map((p)=>ScheduleEntities.fromJson(p)).toList();
    List<dynamic> imageEntities = json['imageEntities'];
    List<ImageEntities> imageentities=imageEntities.map((p)=>ImageEntities.fromJson(p)).toList();
    return Tour(
      id: json['id'],
      name: json['name'],
      codeTour: json['codeTour'],
      startPlace: json['startPlace'],
      endPlace: json['endPlace'],
      province: json['province'],
      national: json['national'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      time: json['time'],
      status: json['status'],
      description: json['description'],
      avatarTour: json['avatarTour'],
      discountPercent: json['discountPercent'],
      priceEntities: priceentities,
      scheduleEntities: scheduleentities,
      imageEntities: imageentities,
    );
  }
}
