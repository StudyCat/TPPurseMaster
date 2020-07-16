import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_dash_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TLDBillDashLine extends StatefulWidget {
  TLDBillDashLine({Key key}) : super(key: key);

  @override
  _TLDBillDashLineState createState() => _TLDBillDashLineState();
}

class _TLDBillDashLineState extends State<TLDBillDashLine> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            child: const TLDDashLine(
              color: Color.fromARGB(255, 242, 242, 242),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          Positioned(
            left: -9,
            child: _getCardCircle(),
          ),
          Positioned(
            right: -9,
            child: _getCardCircle(),
          ),
        ],
      ),
    );
  }

   Widget _getCardCircle() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 242, 242, 242),
      ),
    );
  }
}