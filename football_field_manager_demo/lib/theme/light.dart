import 'package:flutter/material.dart';

ThemeData light() => ThemeData(
      primaryColor: Color(0xff65F057),
      scaffoldBackgroundColor: const Color.fromRGBO(240, 255, 240, 1),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff65F057),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      hintColor: Color(0xffBEC3C7),
      cardColor: Colors.white,
      canvasColor: Colors.black,
      primaryColorLight: Colors.white,
      dividerColor: Color(0xffCBF3BA),
    );
