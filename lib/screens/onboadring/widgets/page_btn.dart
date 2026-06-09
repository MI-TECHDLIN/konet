import 'package:flutter/material.dart';

Widget page_btn(String text, VoidCallback onpressed) {
  return SizedBox(
    height: 56,
    width: 327,
    child: ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(18),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(Color(0xff4F46E5)),
      ),
      onPressed: onpressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    ),
  );
}
