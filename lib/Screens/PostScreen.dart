import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_booking_flutter_v2/Models/Image.dart';
import 'package:travel_booking_flutter_v2/Models/Post.dart';
import 'package:travel_booking_flutter_v2/Models/PostRequest.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/CommunityScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/MainScreen.dart';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();


}
final ButtonStyle elevatedButtonStyle = TextButton.styleFrom(
  foregroundColor: Color(0xfff7892b),
);


class _PostScreenState extends State<PostScreen> {

// You can also directly ask permission about its status.

  PageController? _pageController;
  int _page = 0;
  List navs = ["Trang chủ", "Cộng đồng", "Yêu thích"];
  int _selectedIndex = 0;
  var _image;
  ImagePicker imagePicker=new ImagePicker();
  var type;
  String? requestBody ;
  List<ImageEntities>? images;


  void getImage() async {
    dynamic image = await imagePicker.getImage(source: ImageSource.gallery);
    //var pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }
  dynamic storagePermissionChecker;

  dynamic checkStoragePermission() async {
    final result = await Permission.storage.status;
    setState(() {});
    if (result.isGranted) {
      return 1;
    }
    storagePermissionChecker = requestStoragePermission();
    setState(() {});

    return 0;
  }

  Future<int> requestStoragePermission() async {
    Map<Permission, PermissionStatus> result = await [Permission.storage, Permission.accessMediaLocation,].request();
    return result[Permission.manageExternalStorage].toString()=="PermissionStatus.granted"
        ? 1
        : 0;
  }
  void photoPermission() async {
    var photostatus = await Permission.photos.status;
    var storagestatus= await Permission.manageExternalStorage.status;
    if (photostatus.isDenied || storagestatus.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.manageExternalStorage,
      ].request();
      print(statuses[Permission.photos]);
      print(statuses[Permission.manageExternalStorage]);
      if (await Permission.photos.request().isGranted) {
        getImage();
      }
    } else getImage();

// You can also directly ask permission about its status.

  }
  final _contentController = TextEditingController();
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];
  List<Post>? posts;
  void load() {
    setState(() {
    });
  }
  ProgressDialog? _progressDialog;
  @override
  void initState() {
    super.initState();
    storagePermissionChecker = (() async {
      return await checkStoragePermission();
    })();
    imagePicker = new ImagePicker();
    Api.getPosts().then((value) {
      setState(() {
        posts = value;

      });
    });
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
    return MaterialApp(
        title: "Anime App",
        theme: ThemeData(fontFamily: "Open Sans"),
        debugShowCheckedModeBanner: false,
        home: AddPost(context));
  }

  Widget AddPost(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xffd2fbd2),
                Color(0xff),
              ],
              begin: Alignment.topCenter,
            )),
          ),
          SafeArea(
            child: Column(children: <Widget>[
              Container(
                color: Colors.orangeAccent,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CommunityScreen() ,
                              ),
                            );
                          }),
                      Text(
                        "Đăng bài",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/04.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                  controller: _contentController,
                                  decoration: InputDecoration(
                                      hintText: "Hãy viết gì đó",
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffixIcon: Icon(Icons.filter_list),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 16.0)),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: IconButton(
                                icon: Icon(Icons.send),
                                highlightColor: Colors.grey,
                                onPressed: () {
                                  post();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.shade100,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: _image == null
                                  ? Text('Chọn Ảnh')
                                  : Image.file(_image!),
                            ),
                            _image != null
                                ? Text('')
                                : FloatingActionButton(

                              onPressed: photoPermission,
                              tooltip: 'Pick Image',
                              child: Icon(Icons.add_a_photo),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }
  void post() {
    _progressDialog!.show();
    final String requestBody = json.encoder.convert(images);

    var now = new DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    print(dateFormatted);

    PostRequest postRequest =
    new PostRequest(content: _contentController.text.trim(), time: dateFormatted,imageEntities: "");
    Api.post(postRequest).then((value) {
      _progressDialog!.hide();
      // Fluttertoast.showToast(msg: value.name);
      globals.isCommunity=true;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
    }, onError: (e) {
      _progressDialog!.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) => AdvanceCustomAlert(message: e.toString().substring(11)),
      );
      //   dialogContent(context, e.toString().substring(11));
    });
  }
}
class AdvanceCustomAlert extends StatelessWidget {
  final String? message;

  const AdvanceCustomAlert({Key? key, this.message}) : super(key: key);

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
                    Text('Lỗi', style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red),),
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
                          child: Text('Đóng', style: TextStyle(color: Colors.red),),))
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.assistant_photo, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
}

