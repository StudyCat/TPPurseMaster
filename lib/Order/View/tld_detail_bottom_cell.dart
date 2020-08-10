import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDDetailOrderBottomCell extends StatefulWidget {
  TLDDetailOrderBottomCell({Key key, this.detailOrderModel, this.isBuyer,this.didClickActionBtnCallBack})
      : super(key: key);

  final TLDDetailOrderModel detailOrderModel;

  final bool isBuyer;

  final Function(String) didClickActionBtnCallBack;

  @override
  _TLDDetailOrderBottomCellState createState() =>
      _TLDDetailOrderBottomCellState();
}

class _TLDDetailOrderBottomCellState extends State<TLDDetailOrderBottomCell> {
  List _actionBtnTitleList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TLDOrderStatusInfoModel infoModel =
    TLDDataManager.orderListStatusMap[widget.detailOrderModel.status];
    if (widget.isBuyer == true) {
      _actionBtnTitleList = infoModel.buyerActionButtonTitle;
    } else {
      _actionBtnTitleList = infoModel.sellerActionButtonTitle;
    }
    return Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        child: _getActionBtn(context));
  }

  Widget _getActionBtn(BuildContext context) {
    if (_actionBtnTitleList.length == 0) {
      return Container();
    } else if (_actionBtnTitleList.length == 1) {
      return _getOnlyOneActionBtnView();
    } else {
      return _getTwoActionBtnView(context);
    }
  }

  Widget _getOnlyOneActionBtnView() {
    return Container(
        height: ScreenUtil().setHeight(80),
        child: OutlineButton(
          onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList.first),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
            width: 1,
          ),
          child: Text(
            _actionBtnTitleList.first,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Theme.of(context).hintColor),
          ),
        ));
  }

  Widget _getTwoActionBtnView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(80),
          width: size.width / 2.0 - ScreenUtil().setWidth(40),
          child: OutlineButton(
            onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList[0]),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
              width: 1,
            ),
            child: Text(
              _actionBtnTitleList[0],
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Theme.of(context).hintColor),
            ),
          ),
        ),
        Container(
            width: size.width / 2.0 - ScreenUtil().setWidth(40),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(
                child: Text(
                  _actionBtnTitleList[1],
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28), color: Colors.white),
                ),
                padding: EdgeInsets.all(0),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Theme.of(context).hintColor,
                onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList[1]))),
      ],
    );
  }
}
