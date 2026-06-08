import 'package:flutter/material.dart';
import 'package:konet/screens/onboadring/widgets/page_btn.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

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
                'verify',
                style: TextStyle(fontFamily: 'InstrumentSerif', fontSize: 55),
              ),
              Row(
                children: [
                  Text(
                    'sent to',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    ' +1 (555) 000-0000',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 370,
          left: 15,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 49,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 2.0, color: Color(0xff4F46E5)),
                ),

                child: Text(
                  '8',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff4F46E5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 8),
                height: 49,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),

                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 8),
                height: 49,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),

                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 8),
                height: 49,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),

                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 8),
                height: 49,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),

                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 8),
                height: 49,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),

                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 94,
          top: 244,
          child: Row(
            children: [
              Text(
                "didn't get a code? ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6B7280),
                ),
              ),
              SizedBox(
                child: Text(
                  'resend',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Color(0xff4F46E5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(child: page_btn('continue', () async {})),
      ],
    );
  }
}
