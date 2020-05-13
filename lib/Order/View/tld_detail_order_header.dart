import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDDetailOrderHeaderView extends StatefulWidget {
  TLDDetailOrderHeaderView({Key key}) : super(key: key);

  @override
  _TLDDetailOrderHeaderViewState createState() => _TLDDetailOrderHeaderViewState();
}

class _TLDDetailOrderHeaderViewState extends State<TLDDetailOrderHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(168), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
        child: _getColumnView(context),
        ),
    );
  }

  Widget _getColumnView(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getStatusRowView(context),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: Text('请于14分37秒内向某某某支付。',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),
          )
      ],
    );
  }

  Widget _getStatusRowView(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('待支付',style :TextStyle(fontSize : ScreenUtil().setSp(44),color: Colors.white)),
        IconButton(icon: Icon(IconData(0xe6a2,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(46),color: Colors.white,),onPressed: (){},)
      ],
    );
  }
}