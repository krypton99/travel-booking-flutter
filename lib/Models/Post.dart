import 'Image.dart';

class Post{
  final int id;
  final String content;
  final int amount_like;
  final int amount_comment;
  final String nameUser;
  final String time;
  final List<ImageEntities> imageEntities;
  Post({required this.id,required this.content,required this.amount_comment,required this.amount_like,required this.time,required this.imageEntities,required this.nameUser});
  factory Post.fromJson(Map<String,dynamic>json){
    List<dynamic> imageEntities = json['imageEntities'];
    List<ImageEntities> imageentities=imageEntities.map((p)=>ImageEntities.fromJson(p)).toList();
    return Post(
        id: json['id'],
        content: json['content'],
        amount_like: json['amount_like'],
        amount_comment: json['amount_comment'],
        time: json['time'],
        imageEntities: imageentities,
        nameUser: json['nameUser']
    );
  }
}