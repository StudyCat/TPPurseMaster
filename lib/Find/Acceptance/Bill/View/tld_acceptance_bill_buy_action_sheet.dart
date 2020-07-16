import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceBillBuyActionSheet extends StatefulWidget {
  TLDAcceptanceBillBuyActionSheet({Key key}) : super(key: key);

  @override
  _TLDAcceptanceBillBuyActionSheetState createState() =>
      _TLDAcceptanceBillBuyActionSheetState();
}

class _TLDAcceptanceBillBuyActionSheetState
    extends State<TLDAcceptanceBillBuyActionSheet> {
  int _vote = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: ScreenUtil().setHeight(500),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(40),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('购买票据',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51),
                    decoration: TextDecoration.none)),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                child: _getBillInfoView()),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
              child: _getChooseWidgetView(),
            ),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                child: _getRealAmount()),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(28)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(80),
                  child: CupertinoButton(
                    child: Text(
                      '提交订单',
                      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                    ),
                    onPressed: () {},
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(0),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _getBillInfoView() {
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: Icon(
                IconData(0xe670, fontFamily: 'appIconFonts'),
                size: ScreenUtil().setWidth(40),
                color: Theme.of(context).hintColor,
              )),
              TextSpan(
                  text: '  1级票据',
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102),
                      fontSize: ScreenUtil().setSp(28)))
            ])),
            Text(
              '单价：200TLD',
              style: TextStyle(
                  color: Color.fromARGB(255, 153, 153, 153),
                  fontSize: ScreenUtil().setSp(28),
                  decoration: TextDecoration.none),
            )
          ]),
    );
  }

  Widget _getChooseWidgetView() {
    return Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getSingleChoiceWidget(1),
            _getSingleChoiceWidget(2),
            _getSingleChoiceWidget(3),
            _getSingleChoiceWidget(4),
          ],
        ));
  }

  Widget _getSingleChoiceWidget(int type) {
    String text;
    if (type == 1) {
      text = '1份';
    } else if (type == 2) {
      text = '2份';
    } else if (type == 3) {
      text = '3份';
    } else {
      text = '4份';
    }
    return Row(children: <Widget>[
      Radio(
        value: type,
        groupValue: _vote,
        onChanged: (value) {
          setState(() {
            _vote = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: ScreenUtil().setSp(28)),
          ))
    ]);
  }

  Widget _getRealAmount() {
    return RichText(
        text: TextSpan(
            text: '实付：',
            style: TextStyle(
              color: Color.fromARGB(255, 153, 153, 153),
              fontSize: ScreenUtil().setSp(28),
            ),
            children: <InlineSpan>[
          TextSpan(
            text: '400TLD',
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: ScreenUtil().setSp(48),
            ),
          )
        ]));
  }
}
