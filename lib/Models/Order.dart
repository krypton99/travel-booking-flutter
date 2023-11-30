

class OrderDetail {
  int amount;
  int price;

  OrderDetail({required this.amount, required this.price});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      amount: json['amount'] ?? "",
      price: json['price'] ?? 0,
    );
  }

  Map toJson() {
    return {
      "amount": amount,
      "price": price,
    };
  }
}

class Contact {
  late final int id;
  final String name;
  final String email;
  final String phone;
  final String idCardNumber;
  final int idTour;
  final int idUser;
  final List<OrderDetail> orderDetailRequests;

  Contact(
      {required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.idTour,
        required this.idUser,
        required this.idCardNumber,
        required this.orderDetailRequests});

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "idTour": idTour,
      "idUser": idUser,
      "idCardNumber": idCardNumber,
      "orderDetailRequests": orderDetailRequests,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] ,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      idCardNumber: json['idCardNumber'] ?? "",
      idTour: json['idTour'] ?? 0,
      idUser: json['idUser'] ?? 0,
      orderDetailRequests: <OrderDetail>[]
    );
  }
}

class OrderResponse {
  final int id;
  final int total_price;
  final String tourName;
  final int amount;
  final int price;
  final String urlImage;
  final Contact contact;
  final String orderDate;
  final String date;
  final String place;
  OrderResponse(
      {required this.id,
        required this.orderDate,
        required this.total_price,
        required this.tourName,
        required this.amount,
        required this.price,
        required this.date,
        required this.place,
        required this.urlImage,
        required this.contact});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    // Contact? contact;
    // contact!.id= json['contactResponse']['id'];
    //Contact contactparse=contact.map((p)=>Contact.fromJson(p));
    return OrderResponse(
        id: json['id'],
        total_price: json['total_price'],
        tourName: json['tourName'],
        amount: json['amount'],
        price: json['price'],
        urlImage: json['urlImage'],
        orderDate: json['orderDate'],
        date: json['date'],
        place: json['place'],
        contact: Contact.fromJson(json['contactRequest']),
    );
  }

  Map toJson() {
    return {
      "id": id,
      "total_price": total_price,
      "tourName": tourName,
      "amount": amount,
      "price": price,
      "urlImage": urlImage,
      "contactRequest": contact,
    };
  }
}
