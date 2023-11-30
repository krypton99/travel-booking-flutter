
import 'package:flutter/material.dart';
import 'package:travel_booking_flutter_v2/Models/Post.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/CommentScreen.dart';
import 'package:travel_booking_flutter_v2/globals.dart' as globals;
import 'PostScreen.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}
final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Color(0xfff7892b),
);
class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    try {
      globals.futurePost = Api.getPosts().then((value) {
        setState(() {
          globals.posts = value;
        });
      });
    } catch (e){
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SafeArea(
          child: PostMenu(),
        ),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: globals.posts != null
                        ? ListView.builder(
                      itemCount: globals.posts?.length,
                      itemBuilder: (BuildContext context, int index) =>
                         // Text(index.toString()),
                           CardPost(context, globals.posts!.length - index-1),
                    )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }

  Widget CardPost(BuildContext context, int index) {
    final Post post = globals.posts![index];
    DateTime date;
    String formattedDate;

    if (post != null) {
      date = DateTime.parse(post.time);
      formattedDate =
      "Lúc ${date.hour.toString()}:${date.minute.toString()} ngày ${date.day
          .toString().padLeft(2, '0')}-${date.month.toString().padLeft(
          2, '0')}-${date.year.toString()} ";
    } else
      formattedDate = "0";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: (post.imageEntities.length==0)?200:post.imageEntities[0].image==""?220:500,
        decoration: BoxDecoration(
          color: Color.fromARGB(100, 210, 210, 210),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage("images/user.png"),
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${post == null ? 'Loading...' : post.nameUser}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("${formattedDate}"),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentScreen(post.id),
                        ),
                      );
                    },
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      alignment: Alignment.centerLeft,
                      //padding: const EdgeInsets.only(right: 300.0),
                      child: Text(
                        "${post.content == null ? '' : post.content}",
                      ),
                    ),
                  ),
                  if(post.imageEntities[0].image!="") _getImage(post),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  iconSize: 30.0,
                                  onPressed: () => print('Like post'),
                                ),
                                Text(
                                  "${post == null ? '0' : post.amount_like}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  iconSize: 30.0,
                                  onPressed: () {},
                                ),
                                Text(
                                  "${post == null ? '0' : post.amount_comment}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          iconSize: 30.0,
                          onPressed: () => print('Save post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getImage(Post post) {
    if(post.imageEntities.length == 0)
      return Text("");

    if ( post.imageEntities[0].image==null)
      return Text("");
    else
      return InkWell(
        onDoubleTap: () => print('Like post'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CommentScreen(post.id),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          width: double.infinity,
          height: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 5),
                blurRadius: 8.0,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(post.imageEntities[0].image),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
  }

  Widget PostMenu() {
    return Card(
        color: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
        ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("images/user.png"),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Xin chào ${globals.isLoggedIn == false ? "" : globals
                          .loginResponse?.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 30.0),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                  hintText: "Bạn đang nghĩ gì",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Icon(Icons.filter_list),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
              onTap: () {
                if (globals.isLoggedIn)
                  _create();
                else
                  _requireLogin();
              },
            )
          ],
        ),
      ),
    );
  }

  void _create() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostScreen(),
      ),
    );
  }

  void _requireLogin() {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AdvanceCustomAlert(
              message: "Vui lòng đăng nhập để sử dụng tính năng này", isSuccess: false),
    );
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
