
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class TLDDetailOrderHeaderView extends StatefulWidget {
  TLDDetailOrderHeaderView({Key key,this.detailOrderModel,this.isBuyer,this.timeIsOverRefreshUICallBack}) : super(key: key);

  final TLDDetailOrderModel detailOrderModel;

  final bool isBuyer;

  final Function timeIsOverRefreshUICallBack;

  @override
  _TLDDetailOrderHeaderViewState createState() => _TLDDetailOrderHeaderViewState();
}

class _TLDDetailOrderHeaderViewState extends State<TLDDetailOrderHeaderView> {

  Timer timer;

  static const duration = const Duration(seconds: 1);

  int _countdownTime;

  String _subStr = ''; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.detailOrderModel.expireTime != null){
      _countdownTime = widget.detailOrderModel.expireTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(168), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
        child: _getColumnView(context),
        ),
    );
  }

  Widget _getColumnView(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getStatusRowView(context),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: _getSubContentRowView(),
          )
      ],
    );
  }

  void timerFunction(){
    if(_countdownTime > 0){
      int minute = _countdownTime ~/ 60;
          int second = _countdownTime % 60;
        setState(() {
          _subStr = minute > 0 ? '请于'+minute.toString()+'分'+second.toString()+'秒内向某某某支付。' :   '请于'+second.toString()+'秒内向某某某支付。';
          if (_countdownTime < 0){
            timer.cancel();
            timer = null;
            widget.timeIsOverRefreshUICallBack();
          }
      });
      _countdownTime --;
    }
  }

  Widget _getSubContentRowView(){
    bool isNeedAppeal = false;
    if (widget.detailOrderModel != null){
      switch (widget.detailOrderModel.status) {
        case 0 : {
          if (widget.isBuyer == true){
             if (timer == null){
              timer = Timer.periodic(duration, (timer) { 
                timerFunction();
              });
            }
          }else{
            _subStr = '等待买家付款';
          }
          }
          break;
        case 1 :{
          _subStr = '等待卖家确认';
          isNeedAppeal = true;
        }
        break;
        case -1 :{
          _subStr = '订单已取消';
        }
        break;
        default :{
          
        }
        break;
        }
      }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(_subStr,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),
        Offstage(
          offstage: !isNeedAppeal,
          child: GestureDetector(
            onTap: (){},
            child : Text('申诉',style: TextStyle(fontSize : ScreenUtil().setSp(32),color : Colors.white),),
          ),
        ),
      ],
    );
  }

  Widget _getStatusRowView(BuildContext context){
    String statusStr;
    if (widget.detailOrderModel == null){
      statusStr = '';
    }else{
      TLDOrderStatusInfoModel infoModel = TLDDataManager.orderListStatusMap[widget.detailOrderModel.status];
      statusStr = infoModel.orderStatusName;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(statusStr,style :TextStyle(fontSize : ScreenUtil().setSp(44),color: Colors.white)),
        IconButton(icon: Icon(IconData(0xe6a2,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(46),color: Colors.white,),onPressed: (){},)
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timer != null){
      timer.cancel();
      timer = null;
    }
  }
}