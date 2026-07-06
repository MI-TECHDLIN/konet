import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  MessageCard(
    this.Rradius,
    this.Lradius, {

    required this.messagestring,
    required this.position,
    required this.calcheight,
    required this.color,
    required this.textcolor,
  });
  EdgeInsets position;

  String messagestring;

  Color textcolor;

  String calcheight;
  double Lradius;
  double Rradius;
  int defaultheight = 20;
  int line = 35;
  int color;
  double calc_height() {
    '''
a custome height calculator to increment the height of message 
based on the length of the message.

there is a default values to increment
''';
    int len_height;
    double calc_height;
    if (calcheight.length <= 35) {
      calc_height = 48;
    } else {
      len_height = calcheight.length;
      calc_height = (len_height * defaultheight) / line;
    }
    return calc_height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: position,
      height: calc_height(),
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
