import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
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

class TLDSalePage extends StatefulWidget {
  TLDSalePage({Key key}) : super(key: key);

  @override
  _TLDSalePageState createState() => _TLDSalePageState();
}

class _TLDSalePageState extends State<TLDSalePage> with AutomaticKeepAliveClientMixin {
  List _saleDatas;

  StreamController _controller;

  TLDSaleModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDSaleModelManager();
     _saleDatas = [];
    _controller = StreamController<List>();
    _controller.sink.add(_saleDatas);
  }

  void getSaleListInfo(){
    _modelManager.getSaleList((List dataList){
      setState(() {
        _saleDatas = List.from(dataList);
      });
    } , (TLDError error) {
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
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
            return ListView.builder(
              itemCount: 11,
              itemBuilder: (BuildContext context, int index) {
                return getSaleFirstPageCell(
                    '取消挂售',
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLDDetailSalePage())),
                    context);
              },
            );
          } 
          return TLDSaleNotDataView(didClickCallBack: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TLDExchangePage()));
          },);
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
