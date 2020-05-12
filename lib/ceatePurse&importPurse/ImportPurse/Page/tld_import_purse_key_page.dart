import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import 'tld_import_purse_success_page.dart';

class TLDImportPurseKeyPage extends StatefulWidget {
  TLDImportPurseKeyPage({Key key}) : super(key: key);

  @override
  _TLDImportPurseKeyPageState createState() => _TLDImportPurseKeyPageState();
}

class _TLDImportPurseKeyPageState extends State<TLDImportPurseKeyPage> {

  TextEditingController _controller;

  String _keyString = ''; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
    _controller.addListener((){
      _keyString = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(40)),
          child: Text('请在下面输入您的私钥：',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
              top: ScreenUtil().setHeight(20)),
          height: ScreenUtil().setHeight(288),
          width: size.width - ScreenUtil().setWidth(40),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
                color: Colors.white,
                child: CupertinoTextField(
                  controller: _controller,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(150),
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
                bool isEmpty = (_keyString.length == 0);
                if (isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => TLDAlertView(
                            title: '温馨提示',
                            type: TLDAlertViewType.normal,
                            alertString: '需要将助记词补满哦',
                            didClickSureBtn: () {},
                          ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TLDImportPurseSuccessPage()));
                }
              }),
        )
      ],
    ));
  }
}
