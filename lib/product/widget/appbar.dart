import 'package:flutter/material.dart';

class MovieAppBar extends AppBar {
  MovieAppBar({super.key})
      : super(
          toolbarHeight: 70,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text('MovieDB'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        );
}
