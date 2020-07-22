import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_list_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum TLDAcceptanceProfitListPageType{
  withdrawing,
  withdrawHistory
}

class TLDAcceptanceWithdrawListPage extends StatefulWidget {
  TLDAcceptanceWithdrawListPage({Key key,this.type}) : super(key: key);

  final TLDAcceptanceProfitListPageType type;

  @override
  _TLDAcceptanceWithdrawListPageState createState() => _TLDAcceptanceWithdrawListPageState();
}

class _TLDAcceptanceWithdrawListPageState extends State<TLDAcceptanceWithdrawListPage> with AutomaticKeepAliveClientMixin{

  TLDAcceptanceWithdrawListModelManager _modelManager;

  List _dataSource = [];

  int _page = 1;

  RefreshController _refreshController;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);

    _modelManager = TLDAcceptanceWithdrawListModelManager();
    _getOrderList(_page);
  }

  void _getOrderList(int page){
    if (widget.type == TLDAcceptanceProfitListPageType.withdrawing){
      _modelManager.getWaitPayOrderList(page, (List result){
        _dealOrderList(result, page);
      }, (TLDError error){
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        Fluttertoast.showToast(msg: error.msg);
      });
    }else{
      _modelManager.getOtherStatusOrderList(page, (List result){
        _dealOrderList(result, page);
      }, (TLDError error){
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        Fluttertoast.showToast(msg: error.msg);
      });
    }
  }

  void _dealOrderList(List result,int page){
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
    if (page == 1){
      _dataSource = [];
    }
    if(mounted){
      setState(() {
        _dataSource.addAll(result);
      });
    }
    if (result.length > 0){
      _page = page + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text('刷新完成'),
      ),
      footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("放下加载更多数据");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _page = 1;
        _getOrderList(_page);
      },
      onLoading: () => _getOrderList(_page),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TLDAcceptanceWithdrawOrderListModel orderListModel = _dataSource[index];
      return GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceDetailWithdrawPage(cashNo: orderListModel.cashNo,)));
        },
        child : TLDAcceptanceWithdrawListCell(orderListModel: orderListModel,)
      );
     },
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
   
}