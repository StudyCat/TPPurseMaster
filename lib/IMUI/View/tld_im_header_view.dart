import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDIMHeaderView extends StatefulWidget {
  TLDIMHeaderView({Key key}) : super(key: key);

  @override
  _TLDIMHeaderViewState createState() => _TLDIMHeaderViewState();
}

class _TLDIMHeaderViewState extends State<TLDIMHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Padding(
         padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
         child: Column(
           children : <Widget>[
             _getOrderInfoActionBtnView(),
             Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
               child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(300),
               height: ScreenUtil().setHeight(48),
               decoration: BoxDecoration(
                 borderRadius : BorderRadius.all(Radius.circular(24)),
                 color : Color.fromARGB(255, 216, 216, 216)
               ),
               child: Text('季度信用分：100',style : TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51))),
             ),
             )
           ]
         )
       )
    );
  }

  Widget _getOrderInfoActionBtnView(){
    return Container(
           decoration: BoxDecoration(
             color : Colors.white,
             borderRadius : BorderRadius.all(Radius.circular(4))
           ),
           child: Padding(
             padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(30),right : ScreenUtil().setWidth(30),bottom : ScreenUtil().setHeight(30)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
               children : <Widget>[
                 _getOrderInfoView(),
                 Container(
                   height : ScreenUtil().setHeight(60),
                   width : ScreenUtil().setWidth(190),
                   child: CupertinoButton(
                      color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(0),
                    child: Text('提醒放行',style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(24))),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    onPressed: () {}),
                   ),
               ])
           ),
         );
  }

  Widget _getOrderInfoView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('fsafasf',style : TextStyle(fontSize : ScreenUtil().setSp(22),color : Color.fromARGB(255, 153, 153, 153))),
        Text('fsafsafsafa',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).primaryColor))
      ],
    );
  }
}