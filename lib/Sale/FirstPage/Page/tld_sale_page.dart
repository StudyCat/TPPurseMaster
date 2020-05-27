import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Model/tld_sale_list_info_model.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/View/tld_sale_suspend_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../View/tld_sale_firstpage_cell.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Order/Page/tld_order_list_page.dart';
import '../../../Message/Page/tld_message_page.dart';
import '../../DetailSale/Page/tld_detail_sale_page.dart';
import '../View/tld_sale_not_data_view.dart';
import '../Model/tld_sale_model_manager.dart';
import '../../../Exchange/FirstPage/Page/tld_exchange_page.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDSalePage extends StatefulWidget {
  TLDSalePage({Key key}) : super(key: key);

  @override
  _TLDSalePageState createState() => _TLDSalePageState();
}

class _TLDSalePageState extends State<TLDSalePage> with AutomaticKeepAliveClientMixin {
  List _saleDatas;

  StreamController _controller;

  TLDSaleModelManager _modelManager;

  bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDSaleModelManager();
     _saleDatas = [];
    _controller = StreamController<List>();
    _controller.sink.add(_saleDatas);
    _isLoading = true;
    getSaleListInfo();
  }

  void getSaleListInfo(){
    _modelManager.getSaleList((List dataList){
      setState(() {
        setState(() {
          _isLoading = false;
        });
        _saleDatas = List.from(dataList);
        _controller.sink.add(_saleDatas);
      });
    } , (TLDError error) {
      setState(() {
          _isLoading = false;
        });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

    void _cancelSale(TLDSaleListInfoModel model,int index){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelSale(model, (){
      setState(() {
      _isLoading = false;
    });
      _saleDatas.removeAt(index);
      _controller.sink.add(_saleDatas);
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
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBody(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'sale_page',
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
            width: ScreenUtil().setWidth(160),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TLDOrderListPage()));
                    }),
                MessageButton(
                  didClickCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TLDMessagePage())),
                )
              ],
            )),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return StreamBuilder(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List datas = snapshot.data;
          if ( datas != null) {
            if (datas.length > 0)
            return Stack(
              alignment: FractionalOffset(0.9, 0.95),
              children: <Widget>[
              ListView.builder(
              itemCount: datas.length,
              itemBuilder: (BuildContext context, int index) {
                TLDSaleListInfoModel model = datas[index];
                return getSaleFirstPageCell(
                    '取消挂售',
                    () => _cancelSale(model,index),
                    context,model,()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDDetailSalePage(sellNo: model.sellNo,walletName: model.wallet.name,))));
              },
             ),
             TLDSaleSuspendButton(didClickCallBack:(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => TLDExchangePage())).then((dynamic value){
              setState(() {
                _isLoading = true;
              });
              getSaleListInfo();
            });
             } ,)
              ],
            );
          } 
          return TLDSaleNotDataView(didClickCallBack: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TLDExchangePage())).then((dynamic value){
              setState(() {
                _isLoading = true;
              });
              getSaleListInfo();
            });
          },);
        });
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
