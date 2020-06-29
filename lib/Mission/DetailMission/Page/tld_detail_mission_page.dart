import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDDetailMissionPage extends StatefulWidget {
  TLDDetailMissionPage({Key key}) : super(key: key);

  @override
  _TLDDetailMissionPageState createState() => _TLDDetailMissionPageState();
}

class _TLDDetailMissionPageState extends State<TLDDetailMissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_sale_page',
        transitionBetweenRoutes: false,
        middle: Text('任务详情'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(30),
        right: ScreenUtil().setWidth(30),
        bottom: ScreenUtil().setHeight(30)
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getHeaderView(),
            _getAmountView(),
            _getInfoView(),
            _getFinishMissionTextWidget(),
            _getTimeRowWidget(),
            _getAddressText('我的-钱包地址  ', 'hue2832903hd'),
            _getAddressText('任务-钱包地址  ', 'hue2832903hd')
          ],
        ),
      ),
    );
  }

  Widget _getHeaderView() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(100),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '任务编号：82372932',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153)),
            ),
            RichText(
                text: TextSpan(children: <InlineSpan>[
              WidgetSpan(
                child: CachedNetworkImage(
                  imageUrl:
                      'http://oss.thyc.com/2020/06/29/f4aacae548004e68b373e1e4b7d01ebe.png',
                  width: ScreenUtil().setWidth(24),
                  height: ScreenUtil().setWidth(24),
                ),
              ),
              TextSpan(
                  text: '(20/200)',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 51, 51, 51)))
            ]))
          ]),
    );
  }

  Widget _getAmountView() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getAmountColumnView(
                '实际收益', '0.323TLD', Theme.of(context).primaryColor),
            _getAmountColumnView(
                '累计收益', '0.7823TLD', Color.fromARGB(255, 51, 51, 51))
          ]),
    );
  }

  Widget _getAmountColumnView(String title, String content, Color color) {
    return Column(
      children: <Widget>[
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(48),
              color: color,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 153, 153, 153))),
        )
      ],
    );
  }

  Widget _getInfoView() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getInfoColumnView('最小购买量', '50TLD'),
            _getInfoColumnView('奖励金比例', '0.5%'),
            _getInfoColumnView('奖励金', '0.67TLD'),
            _getInfoColumnView('手续费比例', '5%')
          ]),
    );
  }

  Widget _getInfoColumnView(String title, String content) {
    return Column(
      children: <Widget>[
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51),
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153))),
        )
      ],
    );
  }

  Widget _getFinishMissionTextWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Container(
        padding:
            EdgeInsets.only(left: 5, right: 5, top: ScreenUtil().setHeight(14)),
        height: ScreenUtil().setHeight(56),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 242, 242),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text('当前任务钱包累计完成：100TLD',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51))),
      ),
    );
  }

  Widget _getTimeRowWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Row(children: <Widget>[
        _getTimeTitleColumView(),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setHeight(20)),
          child: _getTimeContentColumView(),
        )
      ]),
    );
  }

  Widget _getTimeTitleColumView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('任务时间段',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153))),
        Text('任务剩余时间',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153))),
      ],
    );
  }

  Widget _getTimeContentColumView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('14:00-18:00',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color.fromARGB(255, 51, 51, 51),
                fontWeight: FontWeight.bold)),
        Text('2:30:32',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color.fromARGB(255, 51, 51, 51),
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _getAddressText(String title, String content) {
    return RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153)),children: <InlineSpan>[
                  TextSpan(
            text: content,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51)))
                ]));
  }
}
