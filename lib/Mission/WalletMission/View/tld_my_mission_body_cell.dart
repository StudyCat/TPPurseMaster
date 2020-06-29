
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDMYMissionBodyCell extends StatefulWidget {
  TLDMYMissionBodyCell({Key key,this.didClickItemCallBack}) : super(key: key);

  final Function didClickItemCallBack;

  @override
  _TLDMYMissionBodyCellState createState() => _TLDMYMissionBodyCellState();
}

class _TLDMYMissionBodyCellState extends State<TLDMYMissionBodyCell> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.didClickItemCallBack,
      child:  Container(
        color : Colors.white,
        child : Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(2)),
          child: Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20),right: 0),
            decoration: BoxDecoration(
              color : Color.fromARGB(255, 242, 242, 242),
              borderRadius:BorderRadius.all(Radius.circular(4))
            ),
            child: _getContentColumnView(),
          ),
        )
    ),
    );
  }

  Widget _getContentColumnView(){
    return Column(
      children : <Widget>[
        _getHeaderRowView(),
        _getMissionInfoView(),
        _getTimeTextWidget()
      ]
    );
  }

  Widget _getTimeTextWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Text('2020-04-23 28:32:56',style: TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
    );
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:<Widget>[
        Container(
          child : Text('任务编号：82372932',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
          width : size.width - ScreenUtil().setWidth(200) 
        ),
        Container(
          width: ScreenUtil().setWidth(74),
          height: ScreenUtil().setHeight(60),
          decoration: BoxDecoration(
            borderRadius : BorderRadius.only(topLeft:Radius.circular(ScreenUtil().setHeight(30)),bottomLeft:Radius.circular(ScreenUtil().setHeight(30))),
            color: Theme.of(context).primaryColor
          ),
        )
      ]
    );
  }

  Widget _getMissionInfoView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getMissionInfoColumWidget('等级', 'L1', null),
          _getMissionInfoColumWidget('额度', '983TLD', null),
          _getMissionInfoColumWidget('奖励金', '0.67TLD', null),
          _getMissionInfoColumWidget('状态', '已支付', Color.fromARGB(255, 240, 131, 30))
        ]
      ),
    );
  }

  Widget _getMissionInfoColumWidget(String title,String content,Color color){
    return Column(
      children: <Widget>[
        Text(title,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 102, 102, 102)),),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(content,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:color != null ? color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

}