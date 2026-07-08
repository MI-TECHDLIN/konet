import 'package:flutter/material.dart';

class thread_selector extends StatefulWidget {
  const thread_selector({super.key});

  @override
  State<thread_selector> createState() => _thread_selectorState();
}

class _thread_selectorState extends State<thread_selector> {
  bool _selected = true;

  void _selector() {
    if (_selected == true) {
      setState(() {
        _selected = false;
      });
    } else {
      setState(() {
        _selected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 15, 18, 10),
      child: Row(
        children: [
          InkWell(
            onTap: _selector,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selected == true
                    ? Color(0xFF000000)
                    : Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(9999),
              ),

              height: 34,
              width: _selected ? 54 : 81,
              child: Text(
                'all',
                style: TextStyle(
                  color: _selected ? Colors.white : Color(0xff6B7280),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: _selector,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selected == true
                    ? Color(0xffFFFFFF)
                    : Color(0xFF000000),
                borderRadius: BorderRadius.circular(9999),
              ),

              height: 36,
              width: _selected ? 81 : 54,
              child: Text(
                'unread',
                style: TextStyle(
                  color: _selected == true
                      ? Color(0xff6B7280)
                      : Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
