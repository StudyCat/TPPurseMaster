import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDDeletePurseSuccessPage extends StatefulWidget {
  TLDDeletePurseSuccessPage({Key key}) : super(key: key);

  @override
  _TLDDeletePurseSuccessPageState createState() => _TLDDeletePurseSuccessPageState();
}

class _TLDDeletePurseSuccessPageState extends State<TLDDeletePurseSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'delete_purse_success_page',
        transitionBetweenRoutes: false,
        middle: Text('删除钱包'),
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
           top: ScreenUtil().setHeight(250),
          ),
          child: Center(
            child: Container(
              height : ScreenUtil().setHeight(80),
              width :  ScreenUtil().setWidth(540),
              child: CupertinoButton(child: Text('完成',style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Colors.white)), padding: EdgeInsets.all(0),color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(4)),onPressed: (){
               Navigator.of(context)..pop();
              }),
            ),
          ),
        )
      ],
    );
  }
}