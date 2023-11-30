import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final ThemeData theme = ThemeData();
class Constants {
  static String appName = "Foody Bite";

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff5563ff);
  static Color darkAccent = Color(0xff5563ff);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow;
  static Color title=Colors.white;
  static Color appBarBackground=Color(0xfff79c4f);
  static BoxDecoration colorBoxDecoration=BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
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
          colors: [Color(0xfffbb448), Color(0xfff7892b)]));

  static ThemeData lightTheme = ThemeData(
    colorScheme: theme.colorScheme.copyWith(secondary: lightAccent),
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
  static final oCcy = new NumberFormat("#,### đ", "en_US");
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: theme.colorScheme.copyWith(secondary: lightAccent),
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
