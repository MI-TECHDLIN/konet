import 'package:flutter/material.dart';

//reusbable card for the first onboarding screen
Widget ReusableFCard(String image, String title, String subtitle) {
  return SizedBox(
    height: 80,
    width: 311,
    child: Card(
      color: const Color(0xFFF8F5F5),
      shadowColor: const Color(0x42FFFFFF),
      elevation: 0.5,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffE8E7F4),
            ),
            child: Image.asset(image, scale: 0.9),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(subtitle),
            ],
          ),
        ],
      ),
    ),
  );
}
