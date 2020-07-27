
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_detail_bill_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_lock_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_unopen_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_profit_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDAcceptanceBillListPage extends StatefulWidget {
  TLDAcceptanceBillListPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceBillListPageState createState() =>
      _TLDAcceptanceBillListPageState();
}

class _TLDAcceptanceBillListPageState extends State<TLDAcceptanceBillListPage> {
  TLDAcceptanceBillListModelManager _modelManager;

  bool _isOpen = false;

  TLDBillBuyPramaterModel _pramaterModel;

  RefreshController _refreshController;

  List _dataSource;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TLDAcceptanceBillListModelManager();

    _getListInfo();
  }

  void _getListInfo() {
    _modelManager.getBillList((List billList) {
      _refreshController.refreshCompleted();
      _dataSource = [];
      if (mounted) {
        setState(() {
          _dataSource.addAll(billList);
        });
      }
    }, (TLDError error) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _buyBill(TLDBillBuyPramaterModel pramaterModel){
    setState(() {
      _isLoading = true;
    });
    _modelManager.buyBill(pramaterModel, (){
      setState(() {
      _isLoading = false;
    });
    _refreshController.requestRefresh();
    _getListInfo();
    }, (TLDError error){
      setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(msg: error.msg);
    });
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
        middle: Text(
          '承兑票据',
          style: TextStyle(color: Colors.white),
        ),
         trailing: GestureDetector(
          onTap :(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceProfitListPage()));
          },
          child : Text('收益记录',style: TextStyle(color:Colors.white,))
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: _getBody(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget() {
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        TLDBillInfoListModel listModel = _dataSource[index];
        if (listModel.lock == true){
          return TLDAcceptanceBillListLockCell(infoListModel: listModel,);
        }else{
          if (listModel.isOpen){
             return _getOpenCell(listModel);
          }else{
            return GestureDetector(
                onTap: () {
                  setState(() {
                    listModel.isOpen = !listModel.isOpen;
                  });
                },
                child: TLDAcceptanceBillListUnOpenCell(infoListModel: listModel,));
          }
        }
      },
    );
  }

  Widget _getOpenCell(TLDBillInfoListModel billModel){
    return TLDAcceptanceBillListOpenCell(
      infoListModel: billModel,
            didClickOpenItemCallBack: (){
              setState(() {
                billModel.isOpen = !billModel.isOpen;
              });
            },
            didClickCheckButtonCallBack: (int index){
              TLDApptanceOrderListModel orderListModel = billModel.orderList[index];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceDetailBillPage(orderNo: orderListModel.acptOrderNo,)));
            },
            didClickBuyButtonCallBack: () {
              if (billModel.totalBuyCount == billModel.alreadyBuyCount){
                Fluttertoast.showToast(msg: '无法再购买了,请购买下一级票据');
                return;
              }
              _pramaterModel = TLDBillBuyPramaterModel();
              _pramaterModel.billId = billModel.billId;
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return TLDAcceptanceBillBuyActionSheet(
                      infoListModel: billModel,
                      didChooseCountCallBack: (int count) {
                        _pramaterModel.count = count;
                      },
                      didClickBuyButtonCallBack: (){
                        _buyBill(_pramaterModel);
                      },
                      didClickChooseWallet: (String walletAddress) {
                        _pramaterModel.walletAddress = walletAddress;
                      },
                    );
                  });
            },
    );
  }

  Widget _getBody() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          color: Theme.of(context).primaryColor,
        ),
        SmartRefresher(
        controller: _refreshController,
        child: _getBodyWidget(),
        header: WaterDropHeader(
          complete: Text('刷新完成'),
        ),
        onRefresh: () {
          _getListInfo();
        },
      )
      ],
    );
  }
}
