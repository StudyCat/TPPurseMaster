import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDPurseBackupWordSuccessPage extends StatefulWidget {
  TLDPurseBackupWordSuccessPage({Key key}) : super(key: key);

  @override
  _TLDPurseBackupWordSuccessPageState createState() =>
      _TLDPurseBackupWordSuccessPageState();
}

class _TLDPurseBackupWordSuccessPageState
    extends State<TLDPurseBackupWordSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('备份助记词'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(214),
          ),
          child: Center(
              child: Icon(
            IconData(0xe65d, fontFamily: 'appIconFonts'),
            size: ScreenUtil().setWidth(150),
            color: Color.fromARGB(255, 218, 225, 238),
          )),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(68),
          ),
          child: Center(
              child: Text('钱包助记词备份成功！',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(40),
          ),
          child: Center(
              child: Text('请妥善保管您的助记词\n切勿丢失或泄漏给他',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.center,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
           top: ScreenUtil().setHeight(80),
          ),
          child: Center(
            child: Container(
              height : ScreenUtil().setHeight(80),
              width :  ScreenUtil().setWidth(540),
              child: CupertinoButton(child: Text('完成',style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Colors.white)), padding: EdgeInsets.all(0),color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(4)),onPressed: (){
               Navigator.of(context)..pop()..pop()..pop();
              }),
            ),
          ),
        )
      ],
    );
  }
}
