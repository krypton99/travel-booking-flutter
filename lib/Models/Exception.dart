class CustomException{
  final String message;

  CustomException({required this.message});
  factory CustomException.fromJson(Map<String,dynamic>json){
    return CustomException(
      message: json['message'],
    );
  }
}