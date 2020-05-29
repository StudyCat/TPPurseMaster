import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDDetailOrderPayMethodCell extends StatefulWidget {
  TLDDetailOrderPayMethodCell({Key key,this.isOpen,this.titleStyle,this.title,this.isBank,this.didClickCallBack}) : super(key: key);

  final String title;

  final TextStyle titleStyle;

  final bool isOpen;

  final bool isBank;

  final Function didClickCallBack;

  @override
  _TLDDetailOrderPayMethodCellState createState() => _TLDDetailOrderPayMethodCellState();
}

class _TLDDetailOrderPayMethodCellState extends State<TLDDetailOrderPayMethodCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : widget.didClickCallBack,
      child : ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: _getContentView(),
    )
    );
  }

  Widget _getContentView(){
    if (widget.isOpen) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(28)),
              child: _getHedaerView(Icon(Icons.keyboard_arrow_down,color: Color.fromARGB(255, 51, 51, 51))),
            ),
            _getPayMethodView()
          ],
        ),
      );
    }else{
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: _getHedaerView(Icon(Icons.keyboard_arrow_right,color: Color.fromARGB(255, 51, 51, 51),)),
      );
    }
  }

  Widget _getHedaerView(Icon arrowIcon){
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),child : Text(
              widget.title,
              style: widget.titleStyle,
            )),
            Container(
              width : ScreenUtil().setWidth(100),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(IconData(0xe61d,fontFamily : 'appIconFonts'),size: ScreenUtil().setWidth(30),),
                Expanded(child: arrowIcon)
              ]
            ),
            )
          ],
      );
  }

  Widget _getPayMethodView(){
    if (widget.isBank == true) {
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(36)),
        child: Column(
          children: <Widget>[
            _getNormalPayInfoView('真实姓名', '张三'),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getBankCodeInfoView(),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getNormalPayInfoView('开户行', '某某银行'),
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(36)),
        child: Column(
          children: <Widget>[
            _getNormalPayInfoView('收款账号', 'fewfwfwq'),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getQrCodePayInfoView(),
            )
          ],
        ),
      );
    }
  }

  // 获取只有两个文字展示的支付信息view
  Widget _getNormalPayInfoView(String title , String content){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
        Text(content,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
      ],
    );
  }

  //获取二维码
  Widget _getQrCodePayInfoView(){
     return GestureDetector(
       onTap : (){},
       child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('二维码',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
        Icon(IconData(0xe640,fontFamily : 'appIconFonts'))
      ],
    )
     );
  }

  //获取银行卡号信息
  Widget _getBankCodeInfoView(){
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('银行卡号',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
         Container(
           width: ScreenUtil().setWidth(270),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
                  child: Text('3231 2133 4322 429',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
                ),
                Padding(
                  padding: EdgeInsets.only(right : ScreenUtil().setWidth(0)),
                  child: Icon(IconData(0xe601,fontFamily : 'appIconFonts',),size: ScreenUtil().setWidth(28),)
                  ),
              ]
            ),
         )],
    );
  }

}