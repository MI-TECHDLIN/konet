import 'package:flutter/material.dart';

class pinned_widget extends StatelessWidget {
  pinned_widget({required this.text, required this.grad1, required this.grad2});

  String text;
  int grad1;
  int grad2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 14, 22, 0),

      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              gradient: LinearGradient(colors: [Color(grad1), Color(grad2)]),
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
