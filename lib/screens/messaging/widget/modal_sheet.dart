import 'package:flutter/material.dart';

class modalsheet extends StatelessWidget {
  const modalsheet({super.key, required this.widget});

  final String widget;

  @override
  Widget build(BuildContext context) {
    //modal  bottom sheet implemeneted for add users in custom collection
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: 460,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a Friend',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
              ),
              SizedBox(height: 5),
              const Text(
                'Share your code or enter a friend\'s',
                style: TextStyle(color: Color(0xff6B7280)),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: 76,
                width: 327,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color(0xFFC8D3F7),
                ),

                child: Text(
                  widget,
                  style: TextStyle(
                    fontSize: 26,

                    fontWeight: FontWeight.bold,
                    color: Color(0xff4F46E5),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: Text(
                  'Tap to copy',
                  style: TextStyle(color: Color(0xff6B7280)),
                ),
              ),

              Container(
                margin: EdgeInsets.all(16),
                // alignment: Alignment.center,
                height: 52,
                width: 327,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xff4F46E5)),
                  ),
                  onPressed: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/share.png'),
                      SizedBox(width: 5),
                      Text(
                        'Share my code',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    height: 1,
                    width: 100,
                    color: Color(0xFF9E9E9E),
                  ),
                  Text('or'),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    height: 1,
                    width: 100,
                    color: Color(0xFF9E9E9E),
                  ),
                ],
              ),

              Center(
                child: Container(
                  //textfield   for sorting friends userid
                  margin: EdgeInsets.only(top: 25),

                  //
                  alignment: Alignment.center,
                  height: 65,
                  width: 327,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hint: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          'Enter friend\'s code',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff6B7280),
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
