import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:travel_booking_flutter_v2/Components/CustomAppBar.dart';
import 'package:travel_booking_flutter_v2/Models/Order.dart';
import 'package:travel_booking_flutter_v2/Models/Price.dart';
import 'package:travel_booking_flutter_v2/Models/Tour.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/PaymentScreen.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
class TourBookingScreen extends StatefulWidget {
  final Tour tour;

  TourBookingScreen(@required this.tour);

  @override
  State<StatefulWidget> createState() => _TourBookingState(tour);
}
final ButtonStyle elevatedButtonStyle = TextButton.styleFrom(
  foregroundColor: Color(0xfff7892b),
);
class _TourBookingState extends State<TourBookingScreen> {
  final Tour? tour;
  List<int>? listOrder = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int>? listPrice = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int? _totalNumberOfPeople = 0;
  int? _totalPrice = 0;
  String? _name;
  String? _email;
  String? _address;
  String? _phone;
  ProgressDialog? _progressDialog;
  _TourBookingState(this.tour);


  @override
  void dispose() {
    super.dispose();
  }

  changeText(index, text) {
    setState(() {
      listOrder![index] = int.parse(text);
    });
  }

  final oCcy = new NumberFormat("#,### đ", "en_US");

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < tour!.priceEntities.length; i++) {
      listPrice![i] = tour!.priceEntities[i].price;
    }
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = new ProgressDialog(context);
    _progressDialog!.style(
        message: 'Vui lòng chờ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    return Scaffold(
      appBar: CustomAppBar(context, "Đặt tour", true),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            _containerContact(),
            Divider(),
            _containerOder(),
            Divider(),
            _containerTotal(),
            SizedBox(
              height: 20,
            ),
            _submitButton(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _containerContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Thông tin liên hệ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            _name = text;
          },
          decoration: InputDecoration(
              labelText: "Họ tên",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            _email = text;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            _address = text;
          },
          decoration: InputDecoration(
              labelText: "Địa chỉ",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: (text) {
            _phone = text;
          },
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              labelText: "Số điện thoại",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
      ],
    );
  }

  Widget _containerOder() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Thông tin đặt vé",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tour!.priceEntities.length,
              itemBuilder: (BuildContext context, int index) => _field(index)
              // Text(index.toString()),
              ),
        ]);
  }

  Widget _field(index) {
    PriceEntities priceEntities = tour!.priceEntities[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            priceEntities.type,
          ),
        ),
        TextField(
          onChanged: (text) {
            if (text != "")
              listOrder![index] = int.parse(text);
            else
              listOrder![index] = 0;
            _setSumPrice();
            // Fluttertoast.showToast(msg: listOrder[index].toString()+"  null");
          },
          //      controller: adultController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: "0",
              counterText:
                  "${oCcy.format(priceEntities == null ? 0 : priceEntities.price)}",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
      ],
    );
  }

  Widget _containerTotal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Tổng số người",
                  ),
                ),
                Container(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: "${_totalNumberOfPeople}",
                        suffixText: "người",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    boxShadow: [],
                  ),
                  height: 50,
                ),
              ],
            )),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Tổng tiền",
                  ),
                ),
                Container(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: "${oCcy.format(_totalPrice)}",
                        suffixText: "đ",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    boxShadow: [],
                  ),
                  height: 50,
                ),
              ],
            )),
          ],
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: new GestureDetector(
        onTap: () {
          if (_isValidationField()) {
            _order();
          }
        },
        child: Text(
          'Đặt ngay',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void _setSumPrice() {
    setState(() {
      int t = 0;
      _totalNumberOfPeople =
          listOrder!.reduce((value, element) => value + element);
      for (int i = 0; i < listPrice!.length; i++) {
        t += (listPrice![i] * listOrder![i]);
      }
      _totalPrice = t;
    });
  }

  bool _isValidationField() {
    if (_name == "" ||
        _name == null ||
        _phone == "" ||
        _phone == null ||
        _address == "" ||
        _address == null ||
        _email == "" ||
        _email == null ||
        _totalNumberOfPeople == 0) {
      Fluttertoast.showToast(msg: "Vui lòng nghập đầy đủ dữ liệu");
      return false;
    }
    // if (_password != _confirmPassword) {
    //   Fluttertoast.showToast(msg: "Mật khẩu không khớp");
    //   return false;
    // }
    // if (_password.length <= 6) {
    //   Fluttertoast.showToast(msg: "Vui lòng nhập mật khẩu hơn 6 ký tự");
    //   return false;
    // }
    return true;
  }

  void _order() {
    _progressDialog!.show();
    OrderDetail? orderDetail = new OrderDetail(amount: listOrder!.reduce((value, element) => value + element), price: _totalPrice!);
    int idUser=0;
    List<OrderDetail> list = <OrderDetail>[];
    for (int i = 0; i < listOrder!.length; i++) {
      if (listOrder![i] > 0) {
        orderDetail.price = listPrice![i];
        orderDetail.amount = listOrder![i];

        list.add(orderDetail);
      }
    }
    Contact contact = new Contact(
        name: _name!, email: _email!, phone: _phone!, orderDetailRequests: list!,idTour: tour!.id,
      idUser:globals.loginResponse!.id,id: 0,idCardNumber: "0"
    );
    Api.order(contact).then((value) {
      _progressDialog!.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AdvanceCustomAlert(message: "Thành công", isSuccess: true),
      );
    }, onError: (e) {
      _progressDialog!.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AdvanceCustomAlert(message: "Thất bại", isSuccess: false),
      );
    });
  }
}

class AdvanceCustomAlert extends StatelessWidget {
  final String? message;
  final bool? isSuccess;
  const AdvanceCustomAlert({Key? key, this.message, this.isSuccess}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    isSuccess! ? Text('Thành công', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.green),) :
                    Text('Lỗi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.red),),
                    SizedBox(height: 5,),
                    Text(
                      message!,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        child: ElevatedButton(onPressed: ()
                        {
                          Navigator.of(context).pop();
                        },
                          style: elevatedButtonStyle,
                          child: Text('Đóng', style: TextStyle(color: Colors.red),),
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: isSuccess! ? Icon(Icons.check, color: Colors.white, size: 50,):Icon(Icons.warning, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
}
