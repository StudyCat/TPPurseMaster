import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_order_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Page/tld_acceptance_detail_order_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_order_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDAcceptanceOrderListPage extends StatefulWidget {
  TLDAcceptanceOrderListPage({Key key}) : super(key: key);


  @override
  _TLDAcceptanceOrderListPageState createState() => _TLDAcceptanceOrderListPageState();
}

class _TLDAcceptanceOrderListPageState extends State<TLDAcceptanceOrderListPage> with AutomaticKeepAliveClientMixin{

  RefreshController _refreshController;

  TLDAcceptanceOrderListModelManager _modelManager;

  int _page = 1;

  List _dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TLDAcceptanceOrderListModelManager();

    _getOrderList(_page);
  }

  void _getOrderList(int page){
    _modelManager.getOrderList(page, (List orderList){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1){
        _dataSource = [];
      }
      setState(() {
        _dataSource.addAll(orderList);
      });
      _page = page + 1;
    }, (TLDError error){
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
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
        heroTag: 'invitation_order_list_page',
        automaticallyImplyLeading: false,
        transitionBetweenRoutes: false,
        middle: Text('TLD票据'),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TLDWebPage(type: TLDWebPageType.billDescUrl,title: '票据说明',)));
        }),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body:  SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
        controller: _refreshController,
        child: _getBodyWidget(),
        header: WaterDropHeader(
          complete: Text('刷新完成'),
        ),
        onRefresh: () {
          _page = 1;
          _getOrderList(_page);
        }, 
        footer : CustomFooter(
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
        onLoading: ()=> _getOrderList(_page),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TLDApptanceOrderListModel listModel = _dataSource[index];
      return TLDAcceptanceOrderListCell(
        orderListModel: listModel,
        didClickItemCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceDetailOrderPage(orderNo: listModel.acptOrderNo,)));
        },
      );
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}