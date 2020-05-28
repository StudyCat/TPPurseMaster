import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_buy_search_field.dart';
import '../View/tld_buy_firstpage_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Order/Page/tld_order_list_page.dart';
import '../View/tld_buy_action_sheet.dart';
import '../../../Message/Page/tld_message_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Model/tld_buy_model_manager.dart';

class TLDBuyPage extends StatefulWidget {
  TLDBuyPage({Key key}) : super(key: key);

  @override
  _TLDBuyPageState createState() => _TLDBuyPageState();
}

class _TLDBuyPageState extends State<TLDBuyPage> with AutomaticKeepAliveClientMixin {

  TLDBuyModelManager _modelManager;

  RefreshController _refreshController;

  bool _isLoading;

  int _page;

  String _keyword;

  List _dataSource;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
    _modelManager = TLDBuyModelManager();
    _refreshController = RefreshController(initialRefresh: true);
    _page = 1;
    _dataSource = [];
    _loadBuyList(_keyword, _page);
  }

  void _loadBuyList(String keyword,int page){
    _modelManager.getBuyListData(keyword, page, (List data){
      if(page == 1){
        _dataSource = [];
      }
     setState(() {
       _dataSource.addAll(data);      
      });
      if(data.length > 0){
        _page = page + 1;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  void buyTLDCoinWithPramaterModel(TLDBuyPramaterModel pramaterModel){
      setState(() {
        _isLoading = true;
      });
    _modelManager.buyTLDCoin(pramaterModel, (){
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: '购买成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.requestRefresh();
      _page = 1;
      _loadBuyList(_keyword, _page);
    }, (TLDError error){
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(size.width)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'buy_page',
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TLDMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: Container(
          width : ScreenUtil().setWidth(160),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
                child: Icon(
                  IconData(0xe663, fontFamily: 'appIconFonts'),
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
                padding: EdgeInsets.all(0),
                minSize: 20,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TLDOrderListPage()));
                }),
            MessageButton(
              didClickCallBack: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => TLDMessagePage())),
            )
          ],
        )
        ),
      ),
    );
  }

  Widget _getRefreshFooter(){
    return CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        );
  }

  Widget _getBodyWidget(double screenWidth){
    return Container(
      width: screenWidth,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TLDBuySearchField(),
        Expanded(
          child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(complete: Text('刷新完成'),),
        footer: _getRefreshFooter(),
        onRefresh: (){
          _page = 1;
          _loadBuyList(_keyword, _page);
        },
        onLoading: (){
          _loadBuyList(_keyword, _page);
        },
        child: _getListView(),
        ) 
        ),
      ],
    ),
    );
  }

  Widget _getListView(){
    return  ListView.builder(
          itemCount: _dataSource.length,
          itemBuilder: (BuildContext context, int index) {
          TLDBuyListInfoModel model = _dataSource[index];
          return TLDBuyFirstPageCell(model: model,didClickBuyBtnCallBack: (){
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDBuyActionSheet(model: model,didClickBuyBtnCallBack: (TLDBuyPramaterModel pramaterModel){
                buyTLDCoinWithPramaterModel(pramaterModel);
              },);
            });
          },);
         },
        );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
