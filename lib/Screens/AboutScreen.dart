import 'package:flutter/material.dart';
import 'package:travel_booking_flutter_v2/Components/CustomAppBar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, "Về Travel Booking", true),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "GIỚI THIỆU",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Travel booking là một ứng dụng di động được xây dựng bằng công nghệ flutter. \n \n "
              "Được xây dựng bởi :\n \n "
              "+ Nguyễn Trọng Khanh \n \n"
              "+ Lý Đạo Nam",
            )
          ],
        ),
      ),
    );
  }
}
