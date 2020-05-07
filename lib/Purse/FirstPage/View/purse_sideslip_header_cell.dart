import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDPurseSideSlipHeaderCell extends StatefulWidget {
  TLDPurseSideSlipHeaderCell({Key key}) : super(key: key);

  @override
  _TLDPurseSideSlipHeaderCellState createState() => _TLDPurseSideSlipHeaderCellState();
}

class _TLDPurseSideSlipHeaderCellState extends State<TLDPurseSideSlipHeaderCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(0),
      width: size.width - 70,
      color: Color.fromARGB(255,51, 114, 255),
      height: 146,
      child: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left : 15,bottom: 5),
            child: Text('总积分',style : TextStyle(fontSize : 14 ,color : Colors.white))
          ),
          Container(
            padding: EdgeInsets.only(left : 15),
            child: Text('132156456TLD',style : TextStyle(fontSize : 20 ,color : Colors.white,fontWeight: FontWeight.bold),)
          ),
        ],
      ),
    );
  }
}