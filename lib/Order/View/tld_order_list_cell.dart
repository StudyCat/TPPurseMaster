import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDOrderListCell extends StatefulWidget {
  TLDOrderListCell({Key key,this.didClickDetailBtnCallBack,this.didClickIMBtnCallBack,this.didClickItemCallBack,this.orderListModel,this.actionBtnTitle = '详情',this.didClickAppealBtn}) : super(key: key);

  final TLDOrderListModel orderListModel;

  final Function didClickIMBtnCallBack;

  final Function didClickDetailBtnCallBack;

  final Function didClickItemCallBack;

  final String actionBtnTitle;

  final Function didClickAppealBtn;

  @override
  _TLDOrderListCellState createState() => _TLDOrderListCellState();
}

class _TLDOrderListCellState extends State<TLDOrderListCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(36),
                bottom: ScreenUtil().setHeight(34)),
            child: _getContentColumn(context)),
      ),
    ),
    );
  }

  Widget _getContentColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _getAdressIMBtn(context),
        _getNumAmountStatusView(context),
        _getDateAndDetailBtn(context),
        _getAppealStatusWidget()
      ],
    );
  }

  Widget _getAdressIMBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          '单号：' + widget.orderListModel.orderNo,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 153, 153, 153)),
        ),
        GestureDetector(
          onTap : widget.didClickIMBtnCallBack,
          child: Icon(
          IconData(0xe609, fontFamily: 'appIconFonts'),
          size: ScreenUtil().setWidth(32),
        ),
        )
      ],
    );
  }

  Widget _getNumAmountStatusView(BuildContext context) {
    TLDOrderStatusInfoModel infoModel = TLDDataManager.orderListStatusMap[widget.orderListModel.status];
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _getInfoView('数量',  widget.orderListModel.txCount + 'TLD', null),
          _getInfoView('金额', '¥' + widget.orderListModel.txCount, null),
          _getInfoView('状态', infoModel.orderStatusName, infoModel.orderStatusColor),
        ],
      ),
    );
  }

  Widget _getInfoView(String title, String content,Color contentColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Theme.of(context).primaryColor),
        ),
        Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
          child: Text(
            content,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: contentColor == null ? Theme.of(context).primaryColor : contentColor,
          ),
        ),
        )],
    );
  }

  Widget _getDateAndDetailBtn(BuildContext context){
     return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.orderListModel.createTime),[yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
           Container(
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setHeight(48),
              child: OutlineButton(
                onPressed: () {
                  widget.didClickDetailBtnCallBack();
                },
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                child: Text(
                  widget.actionBtnTitle,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Theme.of(context).primaryColor),
                ),
              )),
        ],
      ),
    );
  }

  Widget _getAppealStatusWidget(){
    if (widget.orderListModel.appealStatus > -1){
      String appealStatus = '';
      switch (widget.orderListModel.appealStatus) {
        case 0:
          appealStatus = '申诉中';
          break;
        case 1:
          appealStatus = '申诉成功';
          break;
        default:
          appealStatus = '申诉失败';
          break;
      }
      return Padding(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left :ScreenUtil().setWidth(20),right :ScreenUtil().setWidth(20)),
        child : Container(
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(60),
        child: CupertinoButton(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.zero,
          child: Text(appealStatus,textAlign: TextAlign.end,style: TextStyle(fontSize : ScreenUtil().setSp(28),color :Colors.white),), 
          onPressed: widget.didClickAppealBtn)
      ) 
        );
    }else{
      return Container();
    }
  }

}
