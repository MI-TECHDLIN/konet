import 'package:flutter/material.dart';

class LastScreen extends StatelessWidget {
  const LastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'you',
                style: TextStyle(fontSize: 50, fontFamily: 'InstrumentSerif'),
              ),
              SizedBox(height: 5),
              Text(
                'how should people see you?',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),

        Positioned(
          top: 145,
          left: 125,
          child: Column(
            children: [
              Container(
                height: 128,
                width: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF6A88),

                      Color(0xffFF99AC),
                      Color(0xffFF6A88),
                    ],
                  ),
                ),
                child: Image(image: AssetImage('assets/image/profile.png')),
              ),
            ],
          ),
        ),
        Positioned(
          top: 236,
          left: 213,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Image(image: AssetImage('assets/image/cam.png')),
          ),
        ),

        Positioned(
          top: 315,
          left: 20,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF6A88),

                      Color(0xffFF99AC),
                      Color(0xffFF6A88),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
