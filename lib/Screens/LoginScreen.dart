import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:travel_booking_flutter_v2/Components/BezierContainer.dart';
import 'package:travel_booking_flutter_v2/Components/CustomAppBar.dart';
import 'package:travel_booking_flutter_v2/Models/LoginRequest.dart';
import 'package:travel_booking_flutter_v2/Models/LoginResponse.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/SignUpScreen.dart';


import 'ForgotPasswordScreen.dart';
import 'MainScreen.dart';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
class LoginScreen extends StatefulWidget {
  final BuildContext? previousContext;

  LoginScreen({this.previousContext});

  @override
  _LoginScreenState createState() => _LoginScreenState(this.previousContext);
}
final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Color(0xfff7892b),
);
class _LoginScreenState extends State<LoginScreen> {
  final BuildContext? previousContext;

  _LoginScreenState(this.previousContext);
  dynamic _progressDialog;
  late String _username;
  late String _password;
  late Future<dynamic> _futureLoginResponse;

  @override
  void initState() {
    super.initState();
    // this should not be done in build method.
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    _progressDialog = new ProgressDialog(context);
    _progressDialog.style(
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
        "Đăng nhập",
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
                    //_title(),
                    SizedBox(height: 10),
                    _widgetField(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(height: 10),
                    _forgotPasswordLabel(),
                    // _divider(),
                    //_facebookButton(),
                    SizedBox(height: height * .055),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        if (_isValidationField()) login();
        // Navigator.pop(previousContext);
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
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
          'Đăng nhập',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Text('Bạn quên mật khẩu ?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bạn chưa có tài khoản ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                'Đăng ký',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Tài khoản",
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập username',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String val) {
                    _username = val;
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập mật khẩu',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String val) {
                    _password = val;
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
          _emailField(),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _imageLogo() {
    return Image.asset('images/logo.png', height: 150, fit: BoxFit.fill);
  }

  void login() {
    LoginRequest loginRequest =
        new LoginRequest(username: _username.trim(), password: _password.trim());
      _progressDialog.show();
      _futureLoginResponse = Api.login(loginRequest).then((value) {
        _progressDialog.hide();
        globals.loginResponse=value;
        globals.isLoggedIn=true;
        // Fluttertoast.showToast(msg: value.name);
        Navigator.pop(previousContext!);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
      }, onError: (e) {
        _progressDialog.hide();

        showDialog(
          context: context,
          builder: (BuildContext context) => AdvanceCustomAlert(message: e.toString().substring(11), isSuccess: false,),
        );
        //   dialogContent(context, e.toString().substring(11));
      });
  }

  bool _isValidationField() {
    if (_username == "" ||
        _username == null ||
        _password == "" ||
        _password == null) {
      Fluttertoast.showToast(msg: "Vui lòng nghập đầy đủ dữ liệu");
      return false;
    }
    return true;
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

