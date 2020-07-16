import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_lock_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_unopen_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceBillListPage extends StatefulWidget {
  TLDAcceptanceBillListPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceBillListPageState createState() => _TLDAcceptanceBillListPageState();
}

class _TLDAcceptanceBillListPageState extends State<TLDAcceptanceBillListPage> {

  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_bill_list_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑票据',style: TextStyle(color:Colors.white),),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: _getBody(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
      if(index == 0){
        return TLDAcceptanceBillListOpenCell(didClickBuyButtonCallBack: (){
          showCupertinoModalPopup(context: context, builder: (context){
            return TLDAcceptanceBillBuyActionSheet();
          });
        },);
      }else if(index == 1){
        if (_isOpen == false){
          return GestureDetector(
            onTap:(){
              setState(() {
                _isOpen = !_isOpen;
              });
            },
            child: TLDAcceptanceBillListUnOpenCell()
          );
        }else{
          return GestureDetector(
            onTap:(){
              setState(() {
                _isOpen = !_isOpen;
              });
            },
            child: TLDAcceptanceBillListOpenCell(didClickBuyButtonCallBack: (){

            },)
          );
        }
      }else{
        return TLDAcceptanceBillListLockCell();
      }
     },
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
}