import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceInvitationEarningsSearchCell extends StatefulWidget {
  TLDAcceptanceInvitationEarningsSearchCell({Key key,this.didClickSearchCallBack,this.textDidChangeCallBack}) : super(key: key);

  final Function(String) didClickSearchCallBack;

  final Function(String) textDidChangeCallBack;

  @override
  _TLDAcceptanceInvitationEarningsSearchCellState createState() => _TLDAcceptanceInvitationEarningsSearchCellState();
}

class _TLDAcceptanceInvitationEarningsSearchCellState extends State<TLDAcceptanceInvitationEarningsSearchCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40), ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
          color: Colors.white
        ),
        child : CupertinoTextField(
          onChanged: (String text){
            widget.textDidChangeCallBack(text);
          },
           decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
           placeholder: '请输入用户手机号',
           placeholderStyle: TextStyle(fontSize:ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),
           style: TextStyle(fontSize:ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),
           textInputAction: TextInputAction.search,
           prefix : Icon(Icons.search),
           onSubmitted: (String text){
             widget.didClickSearchCallBack(text);
           }, 
        )
      ),
    );
  }
}