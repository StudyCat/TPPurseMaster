import 'package:dragon_sword_purse/Find/Acceptance/Order/Page/tld_acceptance_detail_order_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_order_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceOrderListPage extends StatefulWidget {
  TLDAcceptanceOrderListPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceOrderListPageState createState() => _TLDAcceptanceOrderListPageState();
}

class _TLDAcceptanceOrderListPageState extends State<TLDAcceptanceOrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'invitation_order_list_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑票据'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
      return TLDAcceptanceOrderListCell(
        didClickItemCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceDetailOrderPage()));
        },
      );
     },
    );
  }


}