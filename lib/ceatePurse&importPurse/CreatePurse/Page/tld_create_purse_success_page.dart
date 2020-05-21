import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../dataBase/tld_database_manager.dart';
import '../../../Purse/Settings/Page/tld_purse_setting_backup_word_page.dart';
import '../../../dataBase/tld_database_manager.dart';

class TLDCreatePurseSuccessPage extends StatefulWidget {
  TLDCreatePurseSuccessPage({Key key,this.wallet}) : super(key: key);

  final TLDWallet wallet;
  @override
  _TLDCreatePurseSuccessPageState createState() =>
      _TLDCreatePurseSuccessPageState();
}

class _TLDCreatePurseSuccessPageState extends State<TLDCreatePurseSuccessPage> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'create_purse_success_page',
        transitionBetweenRoutes: false,
        middle: Text('创建钱包'),
        leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
           color: Color.fromARGB(255, 51, 51, 51),
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
      ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        child: _getBodyWidget(context),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
          child:  Center(
              child: Icon(
            IconData(0xe65d, fontFamily: 'appIconFonts'),
            size: ScreenUtil().setWidth(150),
            color: Color.fromARGB(255, 218, 225, 238),
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text('创建钱包成功',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(200),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                '确定',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                 Navigator.popAndPushNamed(context, '/');
              }),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                '助记备份词',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDPurseSeetingBackWordPage(wallet: widget.wallet,)));
              }),
        )
      ],
    ));
  }

}
