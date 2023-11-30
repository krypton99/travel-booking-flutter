class SearchRequest{
  final String endPlace;
  final String endTime;
  final String name;
  final String national;
  final String province;
  final String startPlace;
  final String startTime;
  final String time;
  SearchRequest({required this.endPlace, required this.endTime,required this.name,required this.national,required this.province,required this.startPlace,required this.startTime,required this.time});

  factory SearchRequest.fromJson(Map<String, dynamic> json) {
    return SearchRequest(
        endPlace: json['endPlace'],
        endTime: json['endTime'],
      name: json['name'],
      national: json['national'],
      province: json['province'],
      startPlace: json['startPlace'],
      startTime: json['startTime'],
      time: json['time'],
    );
  }
  Map toJson(){
    return{
      "endPlace":endPlace,
      "endTime":endTime,
      "name":name,
      "national":national,
      "province":province,
      "startPlace":startPlace,
      "startTime":startTime,
      "time":time,
    };
  }
}