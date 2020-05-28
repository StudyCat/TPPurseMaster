import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_order_list_cell.dart';
import 'tld_detail_order_page.dart';
import '../../IM/Page/tld_im_page.dart';
import 'tld_order_appeal_page.dart';
import '../Model/tld_order_list_model_manager.dart';


class TLDOrderListContentPage extends StatefulWidget {
  TLDOrderListContentPage({Key key,this.type}) : super(key: key);

  final int type;

  @override
  _TLDOrderListContentPageState createState() => _TLDOrderListContentPageState();
}

class _TLDOrderListContentPageState extends State<TLDOrderListContentPage> with AutomaticKeepAliveClientMixin {

  TLDOrderListModelManager _modelManager;

  TLDOrderListPramaterModel _pramaterModel;

  List _dataSource;

  RefreshController _refreshController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDOrderListModelManager();

    _pramaterModel = TLDOrderListPramaterModel();
    _pramaterModel.type = widget.type;
    _pramaterModel.page = 1;

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh:true);

    _getOrderListDataWithPramaterModel(_pramaterModel);
  }

  void _getOrderListDataWithPramaterModel(TLDOrderListPramaterModel model){
    _modelManager.getOrderList(model, (List orderList){
      if(model.page == 1){
        _dataSource = [];
      }
      setState(() {
        _dataSource.addAll(orderList);
      });
      if (orderList.length > 0){
        _pramaterModel.page = model.page + 1;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: _getHeaderRefreh(),
      footer: _getFooterRefresh(),
      onRefresh: (){
        _pramaterModel.page = 1;
        _getOrderListDataWithPramaterModel(_pramaterModel);
      },
      onLoading: ()=> _getOrderListDataWithPramaterModel(_pramaterModel),
      child: ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (context ,index) => _getListItem(context, index) 
      ),
      );
  }

  Widget _getHeaderRefreh(){
    return WaterDropHeader(
      complete: Text('刷新完成'),
    );
  }

  Widget _getFooterRefresh(){
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

  Widget _getListItem(BuildContext context,int index){
    TLDOrderListModel model = _dataSource[index];
    return TLDOrderListCell(
      orderListModel: model,
      didClickDetailBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDOrderAppealPage()));
        },
      didClickIMBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage()));
      },
      didClickItemCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailOrderPage()));
      },
      );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}