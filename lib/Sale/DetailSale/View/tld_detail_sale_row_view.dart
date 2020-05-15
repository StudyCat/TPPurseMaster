import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDDetailSaleRowView extends StatefulWidget {
  TLDDetailSaleRowView({Key key,this.isShowIcon,this.title,this.content}) : super(key: key);
  
  final bool isShowIcon;
  final String title;
  final String content;

  @override
  _TLDDetailSaleRowViewState createState() => _TLDDetailSaleRowViewState();
}

class _TLDDetailSaleRowViewState extends State<TLDDetailSaleRowView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          Text(widget.title,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
          widget.isShowIcon ? Icon(IconData(0xe630,fontFamily : 'appIconFonts'), size: ScreenUtil().setWidth(28),) : Text(widget.content,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)))
        ],
      ), 
      );
  }
}