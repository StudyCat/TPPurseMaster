import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDRightBubbleView extends StatefulWidget {
  TLDRightBubbleView({Key key,this.text}) : super(key: key);

  final String text;

  @override
  _TLDRightBubbleViewState createState() => _TLDRightBubbleViewState();
}

class _TLDRightBubbleViewState extends State<TLDRightBubbleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color : Theme.of(context).primaryColor,
        borderRadius : BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),
       child: Text(widget.text,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Colors.white),maxLines: null,),
    );
  }
}