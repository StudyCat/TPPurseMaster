import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDMyMissionHeaderCell extends StatefulWidget {
  TLDMyMissionHeaderCell({Key key,this.didClickItemCallBack,this.isOpen}) : super(key: key);

  final Function didClickItemCallBack;

  final bool isOpen;

  @override
  _TLDMyMissionHeaderCellState createState() => _TLDMyMissionHeaderCellState();
}

class _TLDMyMissionHeaderCellState extends State<TLDMyMissionHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        decoration :BoxDecoration(
          color : Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getHeaderRowView(),
            _getTimeRowView(),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
              child: _getAddressTextWidget('我的-钱包地址：hue2832903hd'),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
              child: _getAddressTextWidget('任务-钱包地址：hue2832903hd'),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: Divider(height: ScreenUtil().setHeight(2),color: Color.fromARGB(255, 198, 198, 198),),
            ),
            GestureDetector(
              onTap: widget.didClickItemCallBack,
              child: Padding(
              padding: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
              child: Center(
                child: Icon(widget.isOpen ? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color:Theme.of(context).primaryColor),
              ),
            ),
            )
          ],
        ),
    );
  }

  Widget _getAddressTextWidget(String content){
    return Text(content,style: TextStyle(fontSize:ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),);
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          _getHeaderColumnView(),
          Container(
            child : CupertinoButton(child: Text('已领取',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 102, 102, 102))), onPressed: (){},padding: EdgeInsets.zero,borderRadius: BorderRadius.all(Radius.circular(4)),color: Color.fromARGB(255, 216, 224, 230),),
            height: ScreenUtil().setHeight(48),
            width: ScreenUtil().setWidth(132),
          )
        ]
      ),
    );
  }

  Widget _getHeaderColumnView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('任务编号：82372932',style: TextStyle(fontSize:ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
        RichText(text: TextSpan(children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: 'http://oss.thyc.com/2020/06/29/f4aacae548004e68b373e1e4b7d01ebe.png',width: ScreenUtil().setWidth(24),height: ScreenUtil().setWidth(24),),),
            TextSpan(text :'(20/200)',style:TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51)))
          ]))
      ],
    );
  }

  Widget _getTimeRowView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getTimeColumnView('任务时间段', '14:00-18:00'),
          _getTimeColumnView('任务剩余时间', '2:30:32')
        ]
      ),
    );
  }

  Widget _getTimeColumnView(String title,String timeStr){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children : <Widget>[
        Text(title,style:TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))),
        Text(timeStr,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.bold))
      ]
    );
  }

}