import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_bill_dash_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceBillListOpenCell extends StatefulWidget {
  TLDAcceptanceBillListOpenCell({Key key,this.didClickBuyButtonCallBack}) : super(key: key);

  final Function didClickBuyButtonCallBack;

  @override
  _TLDAcceptanceBillListOpenCellState createState() =>
      _TLDAcceptanceBillListOpenCellState();
}

class _TLDAcceptanceBillListOpenCellState
    extends State<TLDAcceptanceBillListOpenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: _getHeaderWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: TLDBillDashLine(),
          ),
          _getOrderInfoRowView(),
          _getOrderInfoRowView(),
          _getOrderInfoRowView(),
          _getSaleButtonWidget()
        ]),
      ),
    );
  }

  Widget _getHeaderWidget() {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),bottom : ScreenUtil().setHeight(20)),
        child: Stack(
          children : <Widget>[
           Padding(
            child:  Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
              child: Text('1级TLD票据：100每份（1/4）',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(32),),textAlign: TextAlign.center),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20)
          ),
          Positioned(right: ScreenUtil().setWidth(20),
            child: Icon(Icons.keyboard_arrow_up,color: Color.fromARGB(255, 153, 153, 153),))
          ]
        ),
    );
  }

  Widget _getOrderInfoRowView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(30),left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
      child: Container(
        width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : <Widget>[
            RichText(
              text: TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Icon(
              IconData(0xe670, fontFamily: 'appIconFonts'),
              size: ScreenUtil().setWidth(40),
              color: Theme.of(context).hintColor,
            )),
            TextSpan(
                text: '  订单号：hu92938e9238d2',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontSize: ScreenUtil().setSp(28)))
          ])),
            RichText(
              text: TextSpan(text: '1份',style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51)),children: <InlineSpan>[
            TextSpan(
                text: '  查看',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: ScreenUtil().setSp(28)))
          ]))
          ]
        ),
      ),
      );
  }
  
  Widget _getSaleButtonWidget(){
    return Container(
        padding: EdgeInsets.only(top:ScreenUtil().setHeight(26),bottom: ScreenUtil().setHeight(26)),
        width:ScreenUtil().setWidth(188),
        height : ScreenUtil().setHeight(124),
        child:  CupertinoButton(
            onPressed: widget.didClickBuyButtonCallBack,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(36))),
            padding: EdgeInsets.zero,
            child: Text('购买',style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28))),
            color: Theme.of(context).hintColor,
          ),
    );
  }
}
