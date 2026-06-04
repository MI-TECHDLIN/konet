import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/widgets/reusablecustom_avater.dart';

enum avaterlist { first, second, third, fourth, fifth, sixth }

class LastScreen extends StatefulWidget {
  const LastScreen({super.key});

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  List<Color> avatarcolor = [
    Color(0xffFF6A88),

    Color(0xffFF99AC),
    Color(0xffFF6A88),
  ];
  avaterlist avater = avaterlist.first;
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
                  gradient: LinearGradient(colors: avatarcolor),
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
          left: 8,
          child: Row(
            children: [
              //1
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.first;

                    avatarcolor = [
                      Color(0xffFF6A88),

                      Color(0xffFF99AC),
                      Color(0xffFF6A88),
                    ];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.first,
                  color: [
                    Color(0xffFF6A88),
                    Color(0xffFF99AC),
                    Color(0xffFF6A88),
                  ],
                ),
              ),

              //2
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.second;

                    avatarcolor = [Color(0xff84FAB0), Color(0xff8FD3F4)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.second,
                  color: [Color(0xff84FAB0), Color(0xff8FD3F4)],
                ),
              ),
              //3
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.third;

                    avatarcolor = [Color(0xffA1C4FD), Color(0xffC2E9FB)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.third,
                  color: [Color(0xffA1C4FD), Color(0xffC2E9FB)],
                ),
              ),
              //4
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.fourth;

                    avatarcolor = [Color(0xffF093FB), Color(0xffF5576C)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.fourth,
                  color: [Color(0xffF093FB), Color(0xffF5576C)],
                ),
              ),
              //5
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.fifth;

                    avatarcolor = [Color(0xffFA709A), Color(0xffFEE140)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.fifth,
                  color: [Color(0xffFA709A), Color(0xffFEE140)],
                ),
              ),
              //6
              GestureDetector(
                onTap: () {
                  setState(() {
                    avater = avaterlist.sixth;

                    avatarcolor = [Color(0xff4FACFE), Color(0xff00F2FE)];
                  });
                },
                child: reusablecustomavatar(
                  avater: avater,
                  avaterstate: avaterlist.sixth,
                  color: [Color(0xff4FACFE), Color(0xff00F2FE)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
