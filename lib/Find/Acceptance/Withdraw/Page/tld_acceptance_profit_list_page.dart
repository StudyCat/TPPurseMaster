import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_profit_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_profit_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  TLDAcceptanceProfitModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);

    _modelManager = TLDAcceptanceProfitModelManager();
    _getProfitList(_page);
  }

  void _getProfitList(int page){
    _modelManager.getProfitList(page, (List profitList){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if(page == 1){
        _dataSource = [];
      }
      if(mounted){
        setState(() {
          _dataSource.addAll(profitList);
        });
      }
      if(profitList.length > 0){
        _page = page + 1;
      }
    }, (TLDError error){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

 

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: _getRefresherWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TLDWebPage(urlStr: 'http://128.199.126.189:8080/desc/profit_desc.html',title: '收益记录说明',)));
        }),
        heroTag: 'acceptance_profit_list_page',
        transitionBetweenRoutes: false,
        middle: Text('收益记录'),
      ),
    );
  }


  Widget _getRefresherWidget(){
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
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
        _getProfitList(_page);
      },
      onLoading: () => _getProfitList(_page),
    );
  }


  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TLDAcceptanceProfitListModel profitListModel = _dataSource[index];
      return GestureDetector(
        onTap:(){
        },
        child : TLDAcceptanceProfitListCell(profitListModel: profitListModel,)
      );
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}