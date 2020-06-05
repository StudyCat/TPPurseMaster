import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDLeftBubbleView extends StatefulWidget {
  TLDLeftBubbleView({Key key,this.text}) : super(key: key);

  final String text;

  @override
  _TLDLeftBubbleViewState createState() => _TLDLeftBubbleViewState();
}

class _TLDLeftBubbleViewState extends State<TLDLeftBubbleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius : BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),
       child: Text(widget.text,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),maxLines: null,),
    );
  }
}