import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_body_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_header_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_detail_bill_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceSignPage extends StatefulWidget {
  TLDAcceptanceSignPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceSignPageState createState() => _TLDAcceptanceSignPageState();
}

class _TLDAcceptanceSignPageState extends State<TLDAcceptanceSignPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_sign_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑账户',style: TextStyle(color:Colors.white),),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: _getBody(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        TLDAcceptanceSignHeaderView(didClickLoginCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceDetailBillPage()));
        },),
        TLDAcceptanceSignBodyView()
      ],
    );
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}