import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_booking_flutter_v2/Components/BezierContainer.dart';
import 'package:travel_booking_flutter_v2/Components/CustomAppBar.dart';
import 'package:travel_booking_flutter_v2/Models/User.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/LoginScreen.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _name;
  String? _username;
  String? _password;
  String? _confirmPassword;
  ProgressDialog? _progressDialog;
  Future<dynamic>? _futureUserResponse;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
      appBar: CustomAppBar(
        context,
        "Đăng ký",
        true,
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * 15,
                right: -MediaQuery.of(context).size.width * 0.4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    _imageLogo(),
                    SizedBox(height: 10),
                    _widgetField(),
                    SizedBox(height: 10),
                    _submitButton(),
                    SizedBox(height: 20),
                    //          _submitButton(),
                    SizedBox(height: 10),
                    //             _forgotPasswordLabel(),
                    // _divider(),
                    //_facebookButton(),
                    SizedBox(height: height * .055),
                    //            _createAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Họ tên",
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              new Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập họ tên",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String val) {
                    _name = val.trim().toUpperCase();
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _usernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Tên tài khoản",
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              new Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập username",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String val) {
                    _username = val.trim().toLowerCase();
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Mật khẩu",
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Icon(
                  Icons.security_outlined,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              new Expanded(
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập mật khẩu",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String val) {
                    _password = val.trim();
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Nhập lại mật khẩu",
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Icon(
                  Icons.security_outlined,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              new Expanded(
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập lại mật khẩu",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String val) {
                    _confirmPassword = val.trim();
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _widgetField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _nameField(),
          _usernameField(),
          _passwordField(),
          _confirmPasswordField(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        if (_isValidationField()) {
          _signUp();
        }
      },
      child: Container(
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
        child: Text(
          'Đăng Ký',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _imageLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage("images/user.png"), fit: BoxFit.fill),
      ),
    );
  }

  bool _isValidationField() {
    if (_name == "" ||
        _name == null ||
        _username == "" ||
        _username == null ||
        _password == "" ||
        _password == null ||
        _confirmPassword == "" ||
        _confirmPassword == null) {
      Fluttertoast.showToast(msg: "Vui lòng nghập đầy đủ dữ liệu");
      return false;
    }
    if (_password != _confirmPassword) {
      Fluttertoast.showToast(msg: "Mật khẩu không khớp");
      return false;
    }
    if (_password!.length <= 6) {
      Fluttertoast.showToast(msg: "Vui lòng nhập mật khẩu hơn 6 ký tự");
      return false;
    }
    return true;
  }

  void _signUp() {
    User user = new User(id:-1, username: _username!, password: _password!, name: _name!, phone: "");
    _progressDialog!.show();
    _futureUserResponse = Api.signUp(user).then((value) {
      _progressDialog!.hide();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen(
                previousContext: context,
              )));
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AdvanceCustomAlert(message: "Đăng ký thành công", isSuccess: true),
      );
    }, onError: (e) {
      _progressDialog!.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AdvanceCustomAlert(message: e.toString().substring(11), isSuccess: false),
      );
      //   dialogContent(context, e.toString().substring(11));
    });
  }
}
