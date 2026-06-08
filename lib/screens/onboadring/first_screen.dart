import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/widgets/o_widgets.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 98,

          child: Text(
            'konet',
            style: TextStyle(
              fontSize: 100,
              fontFamily: 'InstrumentSerif',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),

        Positioned(
          left: 55,
          top: 130,

          child: SizedBox(
            height: 60,
            width: 260,
            child: Text(
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
          top: 270,
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
      ],
    );
  }
}
