import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({required this.onpress});
  VoidCallback onpress;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  TextEditingController _password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'choose password',
                style: TextStyle(fontFamily: 'InstrumentSerif', fontSize: 57),
              ),

              Text(
                'make it strong and unique.',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 400,
          left: 15,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),

              borderRadius: BorderRadius.circular(16),
            ),
            height: 55,
            width: 100,
            child: TextField(
              obscureText: true,
              obscuringCharacter: '.',
              controller: _password_controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hint: Text(
                  '.........',
                  style: TextStyle(
                    color: Color(0xff6B7280),
                    fontSize: 20,
                    wordSpacing: 3.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            children: [
              page_btn(btn_text[1], () {
                widget.onpress();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
