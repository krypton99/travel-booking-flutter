
class ScheduleEntities{
  final int id;
  final String time;
  final String place;

  ScheduleEntities({required this.id,required this.time,required this.place});
  factory ScheduleEntities.fromJson(Map<String,dynamic>json){
    return ScheduleEntities(
        id: json['id'],
        time: json['time'],
        place: json['place']
    );
  }
}