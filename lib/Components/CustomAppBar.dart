import 'package:flutter/material.dart';
import 'package:travel_booking_flutter_v2/Utils/Constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(50.0);
  final BuildContext context;
  final String title;
  final bool isBack;

  CustomAppBar(this.context, this.title, this.isBack);

  Widget _backButton() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Constants.title,
            size: 40,
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? back;

    back = _backButton();

    return AppBar(
      centerTitle: true,

      leading: back,
      title: Text(
        title,
        style: TextStyle(color: Constants.title),
      ),
      backgroundColor: Constants.appBarBackground,
      automaticallyImplyLeading: true,
    );
  }
}
