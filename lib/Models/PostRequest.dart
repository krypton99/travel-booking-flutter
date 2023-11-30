import 'dart:convert';

import 'Image.dart';

class PostRequest{
  final String content;
  final String time;
  final String imageEntities;

  PostRequest({required this.content, required this.imageEntities,required this.time});

  factory PostRequest.fromJson(Map<String, dynamic> json) {

    return PostRequest(
      content: json['content'],
      time: json['time'],
      imageEntities: json['imageEntities'],
    );
  }
  Map toJson(){
    return{
      "content":content,
      "imageEntities": [ {"image":imageEntities}],
      "time":time,
    };
  }
}