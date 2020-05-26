import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_sale_suspend_button.dart';

class TLDSaleNotDataView extends StatefulWidget {
  TLDSaleNotDataView({Key key,this.didClickCallBack}) : super(key: key);

  final Function didClickCallBack;

  @override
  _TLDSaleNotDataViewState createState() => _TLDSaleNotDataViewState();
}

class _TLDSaleNotDataViewState extends State<TLDSaleNotDataView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: FractionalOffset(0.9, 0.95),
      children: <Widget>[
        Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
              child: Center(
                  child: Icon(
                IconData(0xe65d, fontFamily: 'appIconFonts'),
                size: ScreenUtil().setWidth(150),
                color: Color.fromARGB(255, 218, 225, 238),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
              child: Text('暂无订单',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 51, 51, 51))),
            ),
          ],
        )),
        TLDSaleSuspendButton(
          didClickCallBack: ()=>widget.didClickCallBack(),
        )
      ],
    );
  }
}
