import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDOrderListCell extends StatefulWidget {
  TLDOrderListCell({Key key,this.didClickDetailBtnCallBack,this.didClickIMBtnCallBack,this.didClickItemCallBack}) : super(key: key);

  final Function didClickIMBtnCallBack;

  final Function didClickDetailBtnCallBack;

  final Function didClickItemCallBack;

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
                top: ScreenUtil().setHeight(36)),
            child: _getContentColumn(context)),
      ),
    ),
    );
  }

  Widget _getContentColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        _getAdressIMBtn(context),
        _getNumAmountStatusView(context),
        _getDateAndDetailBtn(context)
      ],
    );
  }

  Widget _getAdressIMBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          '地址：21321342134323423413231',
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
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _getInfoView('数量', '4654TLD', null),
          _getInfoView('金额', '¥5451', null),
          _getInfoView('状态', '已完成', Color.fromARGB(255, 208, 2, 27)),
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
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24),bottom: ScreenUtil().setHeight(34)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('2020.03.18',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
           Container(
              width: ScreenUtil().setWidth(122),
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
                  '详情',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Theme.of(context).primaryColor),
                ),
              )),
        ],
      ),
    );
  }

}
