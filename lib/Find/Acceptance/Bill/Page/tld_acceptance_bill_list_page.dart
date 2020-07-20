import 'dart:ffi';

import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_detail_bill_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_lock_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_unopen_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Model/tld_acceptance_login_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDAcceptanceBillListPage extends StatefulWidget {
  TLDAcceptanceBillListPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceBillListPageState createState() => _TLDAcceptanceBillListPageState();
}

class _TLDAcceptanceBillListPageState extends State<TLDAcceptanceBillListPage> {

  TLDAcceptanceLoginModelManager _modelManager;

  bool _isOpen = false;

  TLDBillBuyPramaterModel _pramaterModel;

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh:true);

    _pramaterModel = TLDBillBuyPramaterModel();

    _modelManager = TLDAcceptanceLoginModelManager();
  }

  void _getListInfo(){

  }

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
      body: SmartRefresher(
        controller: _refreshController,
        child: _getBody(),
        header: WaterDropHeader(
          complete: Text('刷新完成'),
        ),
        onRefresh: (){
          
        },
      ),
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
            return TLDAcceptanceBillBuyActionSheet(
              walletName: _pramaterModel.walletName,
              didChooseCountCallBack: (int count){
                _pramaterModel.count = count;
              },
              didClickChooseWallet: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDEchangeChooseWalletPage(
                  didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
                    _pramaterModel.walletAddress = infoModel.walletAddress;
                    _pramaterModel.walletName = infoModel.wallet.name;
                  },
                )));
                
              },
            );
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

            },didClickCheckButtonCallBack: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceDetailBillPage()));
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