class PriceEntities{
  final int id;
  final String type;
  final bool primary;
  final int price;
  PriceEntities({required this.id,required this.price,required this.primary,required this.type});
  factory PriceEntities.fromJson(Map<String,dynamic>json){
    return PriceEntities(
        id: json['id'],
        type: json['type'],
        primary: json['primary'],
        price: json['price']
    );
  }
}