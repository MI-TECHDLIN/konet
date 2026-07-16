import 'package:flutter/material.dart';
import 'package:konet/screens/messaging/chat_screen.dart';

class inbox_card extends StatelessWidget {
  inbox_card({
    super.key,
    required this.userid,
    required this.grad1,
    required this.grad2,
    required this.label,
    required this.displayname,
    required this.newthread,
  });

  int grad1;
  int grad2;
  String userid;
  String label;
  String displayname;
  String newthread;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => ChatScreen(userid: userid)),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(25, 15, 0, 6),

                  alignment: Alignment.center,
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Color(0xff + grad1), Color(0xff + grad2)],
                    ),
                  ),
                  child: Text(
                    label,

                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(18, 5, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayname,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 8),
                      Text(newthread),
                    ],
                  ),
                ),
              ],
            ),

            Divider(thickness: 2),
          ],
        ),
      ),
    );
  }
}
