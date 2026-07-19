import 'package:flutter/material.dart';
import 'package:konet/constant/constant.dart';
import 'package:konet/screens/onboadring/widgets/o_widgets.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

// ignore: must_be_immutable
class FirstScreen extends StatefulWidget {
  FirstScreen({super.key, required this.onpress});

  VoidCallback onpress;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 98,

          child: const Text(
            'konet',
            style: TextStyle(
              fontSize: 100,
              fontFamily: 'InstrumentSerif',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),

        Positioned(
          left: 50,
          top: 128,
          child: SizedBox(
            height: 60,
            width: 260,
            child: const Text(
              'a quiet place to talk to the people you love.',
              textAlign: .center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'inter',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),

        Positioned(
          top: 250,
          left: 20,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 330,
                child: Column(
                  children: [
                    ReusableFCard(
                      'assets/image/Vector.png',
                      'No ads, no tracking',
                      'Your data stays on your device.',
                    ),
                    SizedBox(height: 10),

                    ReusableFCard(
                      'assets/image/Img.png',
                      'Calm by design',
                      'No read reciepts, no typing indicators.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            children: [
              page_btn(btn_text[0], () {
                widget.onpress();
              }),

              SizedBox(height: 18),
              const Text(
                'By continuing, you agree to our quiet terms.'
                '',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
