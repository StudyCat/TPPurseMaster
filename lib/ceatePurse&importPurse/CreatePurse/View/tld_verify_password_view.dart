import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDVerifyPasswordView extends StatefulWidget {
  TLDVerifyPasswordView({Key key,this.password}) : super(key: key);

  final String password;

  @override
  _TLDVerifyPasswordViewState createState() => _TLDVerifyPasswordViewState();
}

class _TLDVerifyPasswordViewState extends State<TLDVerifyPasswordView> {
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        padding : EdgeInsets.only(top : ScreenUtil().setHeight(26),left : ScreenUtil().setWidth(20),bottom:ScreenUtil().setHeight(24)),
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : <Widget>[
            Text('为了您的资产安全，密码强度要求如下：',style: TextStyle(
              fontSize : ScreenUtil().setSp(28),
              color : Color.fromARGB(255, 51, 51, 51)
            ),),
            getVerifyItem('至少一个大写字母', _isHaveCapital()),
            getVerifyItem('至少一个小写字母', _isHaveLowercase()),
            getVerifyItem('至少一个数字', _isHaveNum()),
            getVerifyItem('总共8～32个字符', _isLengthLegal())
          ],
        )
      ),
    );
  }

  Widget getVerifyItem(String content , bool isPass){
    return Row(
      children : <Widget>[
        Container(
          width: ScreenUtil().setWidth(300),
          child: Text('·'+ content, style: TextStyle(color : isPass ? Color.fromARGB(255, 68, 149, 34) : Color.fromARGB(255, 208, 2, 27),fontSize: ScreenUtil().setSp(28)),),
        ),
        Container(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(40)),
          child: Icon(IconData(isPass?0xe602 : 0xe616 ,fontFamily: 'appIconFonts',),color: isPass ? Color.fromARGB(255, 68, 149, 34) : Color.fromARGB(255, 208, 2, 27) ,size: ScreenUtil().setWidth(28),),
        )
      ],
    );
  }

  bool _isHaveCapital(){
    if (widget.password == null){
      return false;
    }
    return RegExp(r"[A-Z]").hasMatch(widget.password); 
  }

  bool _isHaveLowercase(){
    if (widget.password == null){
      return false;
    }
    return RegExp(r"[a-z]").hasMatch(widget.password);
  }

  bool _isHaveNum(){
    if (widget.password == null){
      return false;
    }
    return RegExp(r"[0-9]").hasMatch(widget.password);
  }

  bool _isLengthLegal(){
    if (widget.password == null){
      return false;
    }
    return (widget.password.length > 7 && widget.password.length < 33);
  }

}