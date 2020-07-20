import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_detail_order_amount_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_detail_order_header_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceDetailOrderPage extends StatefulWidget {
  TLDAcceptanceDetailOrderPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceDetailOrderPageState createState() => _TLDAcceptanceDetailOrderPageState();
}

class _TLDAcceptanceDetailOrderPageState extends State<TLDAcceptanceDetailOrderPage> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body:  NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_getAppBar()];
          },
          body: _getBodyWidget(context)
          ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }



  Widget _getAppBar() {
    return SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      backgroundColor: Theme.of(context).primaryColor,
      leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floating: true, //不随着滑动隐藏标题
      pinned: true, //不固定在顶部
      title: Text('订单详情'),
      flexibleSpace: FlexibleSpaceBar(
        background: TLDAcceptanceDetailOrderHeaderCell(),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          if (index == 1){
            return TLDAcceptanceDetailOrderAmountCell();
          }else{
            double top = 0.0;
            if(index == 2){
              top = ScreenUtil().setHeight(10);
            }else{
              top = ScreenUtil().setHeight(2);
            }
            return _getNormalCell( top, index);
          }
        });
  }

    Widget _getNormalCell( num top, int index) {
    String content = '';
    String title = '';
    if(index == 0){
      title = '订单号';
      content = '6391649136894';
    }else if(index == 2){
      title = '每天静态收益';
      content = '72÷60=1.2TLD';
    }else if(index == 3){
      title = '收益倍率';
      content = '2.00';
    }else{
      title = '预计承兑累积收益';
      content = '72TLD';
    }
    return Padding(
      padding: EdgeInsets.only(
          top: top,
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normal,
          title: title,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: content,
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    );
  }

}