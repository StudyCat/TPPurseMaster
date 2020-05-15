
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_detail_sale_info_view.dart';
import '../View/tld_detail_sale_row_view.dart';

class TLDDetailSalePage extends StatefulWidget {
  TLDDetailSalePage({Key key}) : super(key: key);

  @override
  _TLDDetailSalePageState createState() => _TLDDetailSalePageState();
}

class _TLDDetailSalePageState extends State<TLDDetailSalePage> {
  List titles = [
    '收款方式',
    '挂售钱包',
    '限额',
    '手续费率',
    '手续费',
    '预计到账',
    '创建时间',
  ];

  List contents = [
    'yeiwpgwepgwdpde09328',
    '3249TLD',
    '千分之六',
    '¥783',
    '2020-05-05',
    '2020-04-30',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_sale_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return  Container(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)), 
          child: Container(
            padding : EdgeInsets.only(left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
            color: Colors.white,
            child :  ListView.builder(
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(top : ScreenUtil().setHeight(36)),
                  child: Text('地址：214234124324',style:TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153))),
                );
              }else if (index == 1){
                return TLDDetailSaleInfoView();
              }else{
                bool isShowIcon = false;
                String content  = '';
                if (index == 2) {
                  isShowIcon = true;
                }else{
                  content = contents[index - 3];
                }
                return TLDDetailSaleRowView(isShowIcon: isShowIcon,title: titles[index - 2],content: content,);
              }
           },
          )
          ),
        ),
      );
  }
}