import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDEmptyWalletView extends StatefulWidget {
  TLDEmptyWalletView({Key key}) : super(key: key);

  @override
  _TLDEmptyWalletViewState createState() => _TLDEmptyWalletViewState();
}

class _TLDEmptyWalletViewState extends State<TLDEmptyWalletView> {
  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(214),
          ),
          child: Center(
              child: Image.asset('assetss/images/no_purse_page_icon.png',width:ScreenUtil().setWidth(260),height: ScreenUtil().setWidth(260),) 
              ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(68),
          ),
          child: Center(
            child: Text('暂无可用的钱包',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
      ],
    );
  }
}