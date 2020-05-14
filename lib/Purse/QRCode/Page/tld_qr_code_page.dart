import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:typed_data';

class TLDQRCodePage extends StatefulWidget {
  TLDQRCodePage({Key key}) : super(key: key);

  @override
  _TLDQRCodePageState createState() => _TLDQRCodePageState();
}

class _TLDQRCodePageState extends State<TLDQRCodePage> {

  Uint8List bytes = Uint8List(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _generateBarCode('www.baidu.com');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'qr_code_page',
        transitionBetweenRoutes: false,
        middle: Text('收款码'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return  Container(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
        height: size.height - ScreenUtil().setHeight(170),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(24)),
            color: Colors.white,
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(66)),
                child: Image.asset('assetss/images/tld_icon.png',width: ScreenUtil().setWidth(236),height: ScreenUtil().setHeight(54),alignment: Alignment.center,),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                child: bytes != null ? Image.memory(bytes,width: ScreenUtil().setWidth(408),height: ScreenUtil().setHeight(408),alignment: Alignment.center,) : Container(width: ScreenUtil().setWidth(408),height: ScreenUtil().setHeight(408),color: Color.fromARGB(255, 103, 103, 103),),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(50),left :ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
                child: getCopyAdressView(context),
              )
            ],
          ),
          ),
        ),
      );
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
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
            width: size.width - ScreenUtil().setWidth(240),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            child: Text(
              '456456565dqwdqwdqwdwqdwqdqwqwdqw',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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

}
