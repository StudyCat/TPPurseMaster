import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonFunction/tld_common_function.dart';


class TLDMyPurseHeaderView extends StatefulWidget {
  TLDMyPurseHeaderView({Key key,this.didClickTransferAccountsBtnCallBack,this.didClickQRCodeBtnCallBack,this.infoModel}) : super(key: key);

  final TLDWalletInfoModel infoModel;

  final Function didClickTransferAccountsBtnCallBack;

  final Function didClickQRCodeBtnCallBack;

  @override
  _TLDMyPurseHeaderViewState createState() => _TLDMyPurseHeaderViewState();
}

class _TLDMyPurseHeaderViewState extends State<TLDMyPurseHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(48)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getNumView(),
          getCopyAdressView(context),
          getButtonView(context)
        ],
      ),
    );
  }

  Widget getNumView() {
    return Container(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RichText(
                  text: TextSpan(
                    text : getMoneyStyleStr(widget.infoModel.value),
                    style : TextStyle(fontSize : ScreenUtil().setSp(52),color : Theme.of(context).primaryColor),
                    children: <InlineSpan>[
                      TextSpan(
                        text : '  TLD',
                        style: TextStyle(fontSize : ScreenUtil().setSp(24),color :Theme.of(context).primaryColor)
                      )
                    ],
                  ),
                ),
            Container(
              width: ScreenUtil().setWidth(142),
              height: ScreenUtil().setHeight(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                // color: Color.fromARGB(255, 51, 114, 245)
              ),
              child: RaisedButton(
                child: Text('兑换',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28), color: Colors.white)),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ));
  }


  Widget getCopyAdressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(255, 230, 230, 230),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width - ScreenUtil().setWidth(190),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(36)),
            child: Text(
              widget.infoModel.wallet.address,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 102, 102, 102)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(50),
                bottom: ScreenUtil().setHeight(20)),
            height: ScreenUtil().setWidth(32),
            width: ScreenUtil().setWidth(32),
            child: IconButton(
                icon: Icon(
                  IconData(0xe601, fontFamily: 'appIconFonts'),
                  size: ScreenUtil().setWidth(32),
                ),
                onPressed: () {}),
          )
        ],
      ),
    );
  }

  Widget getButtonView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              width: (size.width - ScreenUtil().setWidth(90)) / 2,
              height: ScreenUtil().setHeight(80),
              child: OutlineButton(
                onPressed: widget.didClickQRCodeBtnCallBack,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                child: Text(
                  '收款码',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Theme.of(context).primaryColor),
                ),
              )),
          Container(
              width: (size.width - ScreenUtil().setWidth(90)) / 2,
              height: ScreenUtil().setHeight(80),
              child: CupertinoButton(
                onPressed: widget.didClickTransferAccountsBtnCallBack,
                child: Text(
                  '转账',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28), color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(0),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              )),
        ],
      ),
    );
  }
}
