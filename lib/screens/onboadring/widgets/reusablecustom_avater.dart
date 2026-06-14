import 'package:flutter/material.dart';

enum avaterlist { first, second, third, fourth, fifth, sixth }

Widget reusablecustomavatar({
  avaterlist? avater,
  avaterlist avaterstate = avaterlist.first,
  final List<Color>? color,
}) {
  return Container(
    margin: EdgeInsets.only(right: 0),
    padding: EdgeInsets.all(6),
    height: 60,
    width: 60,
    decoration: avater == avaterstate
        ? BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xff4F46E5), width: 2),
            borderRadius: BorderRadius.circular(999),
          )
        : BoxDecoration(),
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        gradient: LinearGradient(colors: color!),
      ),
    ),
  );
}
