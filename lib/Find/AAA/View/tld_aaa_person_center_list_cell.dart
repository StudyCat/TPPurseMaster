import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TLDAAAPersonCenterListCell extends StatefulWidget {
  TLDAAAPersonCenterListCell({Key key,this.index}) : super(key: key);

  final int index;

  @override
  _TLDAAAPersonCenterListCellState createState() => _TLDAAAPersonCenterListCellState();
}

class _TLDAAAPersonCenterListCellState extends State<TLDAAAPersonCenterListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        color : Colors.white,
        padding: EdgeInsets.only(top :widget.index == 0 ? ScreenUtil().setHeight(30) : ScreenUtil().setHeight(5),bottom :ScreenUtil().setHeight(5),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
        child : _getContentWidget()
      ),
    );
  }

  Widget _getContentWidget(){
    return Container(
      padding:  EdgeInsets.only(top :ScreenUtil().setHeight(20),bottom :ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        color : Color.fromARGB(255, 242, 242, 242),
        borderRadius : BorderRadius.all(Radius.circular(4))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: ScreenUtil.screenWidth - ScreenUtil().setWidth(140),
            child: Text('张三向我发起升级',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51))),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: _getInfoWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: Text('2020.09.09 09:09:09',style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
          ),
        ],
      ),
    );
  }

  Widget _getInfoWidget(){
    return Container(
            width: ScreenUtil.screenWidth - ScreenUtil().setWidth(140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 RichText(
              text: TextSpan(
                children : <InlineSpan>[
                  WidgetSpan(
                    child : CachedNetworkImage(imageUrl: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3303266263,407158830&fm=26&gp=0.jpg',width: ScreenUtil().setSp(48),height: ScreenUtil().setSp(48),),
                  ),
                   WidgetSpan(
                    child : Icon(IconData(0xe632,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24)),
                  ),
                  WidgetSpan(
                    child : CachedNetworkImage(imageUrl: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3303266263,407158830&fm=26&gp=0.jpg',width: ScreenUtil().setSp(48),height: ScreenUtil().setSp(48),),
                  ),
                ]
              ),
            ),
             Text('+20TLD',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Color.fromARGB(255, 65, 117, 5))),
            ],
            ),
    );
  }

}