class ImageEntities{
  final int id;
  final String image;

  ImageEntities({required this.id,required this.image});
  factory ImageEntities.fromJson(Map<String,dynamic>json){
    return ImageEntities(
      id: json['id'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() => {'id': id,'image':image};
}
class ImageList {
  ImageList(this.images);

  List<ImageEntities> images;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'imageEntites': images,
  };
}