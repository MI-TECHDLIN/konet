import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  MessageCard(
    this.Rradius,
    this.Lradius, {
    required this.messagestring,
    required this.position,
    required this.color,
    required this.textcolor,
  });
  EdgeInsets position;

  String messagestring;

  Color textcolor;

  double Lradius;
  double Rradius;

  int color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: position,
      height: 110.25,
      width: 274.39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(Rradius),
          bottomLeft: Radius.circular(Lradius),
          topLeft: Radius.circular(24),
        ),
        color: Color(color),
      ),
      child: Text(messagestring, style: TextStyle(color: textcolor)),
    );
  }
}
