import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_order_list_cell.dart';
import 'tld_detail_order_page.dart';
import '../../IMUI/Page/tld_im_page.dart';
import 'tld_order_appeal_page.dart';
import '../Model/tld_order_list_model_manager.dart';

class TLDOrderListContentController  extends ValueNotifier<int>{
    TLDOrderListContentController(int status) : super(status);
}


class TLDOrderListContentPage extends StatefulWidget {
  TLDOrderListContentPage({Key key,this.type,this.controller,this.walletAddress}) : super(key: key);

  final String walletAddress;

  final int type;

  final TLDOrderListContentController controller;

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
    if (widget.walletAddress != null){
      _pramaterModel.walletAddress =  widget.walletAddress;
    }

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh:true);

    _getOrderListDataWithPramaterModel(_pramaterModel);

    widget.controller.addListener(() {
      int status = widget.controller.value;
      if (status == null){
        if (_pramaterModel.status != null){
          _pramaterModel.status = null;
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        }
      }else{
        if (_pramaterModel.status != status){
           _pramaterModel.status = status;
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        }
      }
    });
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
    bool isBuyer =  widget.type == 1 ? true : false;
    String selfAddress = isBuyer == true ? model.buyerAddress : model.sellerAddress;
     String otherAddress = isBuyer == false ? model.buyerAddress : model.sellerAddress;
    return TLDOrderListCell(
      orderListModel: model,
      didClickDetailBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailOrderPage(orderNo: model.orderNo,isBuyer:isBuyer,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        });
        },
      didClickIMBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(selfWalletAddress: selfAddress,otherGuyWalletAddress: otherAddress,orderNo: model.orderNo,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        });
      },
      didClickItemCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailOrderPage(orderNo: model.orderNo,isBuyer: isBuyer,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        });
      },
      );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}