import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_detail_bill_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TLDAcceptanceDetailBillPage extends StatefulWidget {
  TLDAcceptanceDetailBillPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceDetailBillPageState createState() => _TLDAcceptanceDetailBillPageState();
}

class _TLDAcceptanceDetailBillPageState extends State<TLDAcceptanceDetailBillPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_detail_bill_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑票据订单详情',style: TextStyle(color:Colors.white),),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: _getBody(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return TLDAcceptanceDetailBillView();
  }

  Widget _getBody(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          color: Theme.of(context).primaryColor,
        ),
        _getBodyWidget()
      ],
    );
  }

}