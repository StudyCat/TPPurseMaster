import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_clip_common_cell.dart';

class TLDIntegrationDescPage extends StatefulWidget {
  TLDIntegrationDescPage({Key key}) : super(key: key);

  @override
  _TLDIntegrationDescPageState createState() => _TLDIntegrationDescPageState();
}

class _TLDIntegrationDescPageState extends State<TLDIntegrationDescPage> {
 List titles = [
    '兑换比例：1TLD=1CNY',
    '手续费：0.1%',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'integration_desc_page',
        transitionBetweenRoutes: false,
        middle: Text('积分兑换说明'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index){
       return Padding(
         padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
         child: TLDClipCommonCell(type : TLDClipCommonCellType.normal,title: titles[index],titleStyle: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),content: '',contentStyle: TextStyle(),),
       ); 
      });
  }
}