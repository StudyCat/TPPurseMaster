import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDPurseSideSlipHeaderCell extends StatefulWidget {
  TLDPurseSideSlipHeaderCell({Key key,this.totalAmount}) : super(key: key);

  final String totalAmount;

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
      color: Theme.of(context).primaryColor,
      height: 146,
      child: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left : 15,bottom: 5),
            child: Text('总积分（TLD）',style : TextStyle(fontSize : 14 ,color : Theme.of(context).hintColor))
          ),
          Container(
            padding: EdgeInsets.only(left : 15),
            child: Text(widget.totalAmount,style : TextStyle(fontSize : 20 ,color : Theme.of(context).hintColor,fontWeight: FontWeight.bold),)
          ),
        ],
      ),
    );
  }
}