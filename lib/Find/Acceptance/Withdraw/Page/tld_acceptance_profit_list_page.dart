import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_profit_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class TLDAcceptanceProfitListPage extends StatefulWidget {
  TLDAcceptanceProfitListPage({Key key,}) : super(key: key);

  @override
  _TLDAcceptanceProfitListPageState createState() => _TLDAcceptanceProfitListPageState();
}

class _TLDAcceptanceProfitListPageState extends State<TLDAcceptanceProfitListPage> with AutomaticKeepAliveClientMixin {


  List _dataSource = [];

  int _page = 1;

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);

    _getOrderList(_page);
  }

  void _getOrderList(int page){
    
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
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap:(){
          
        },
        child : TLDAcceptanceProfitListCell()
      );
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}