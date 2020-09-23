
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAAAPersonCenterHeaderView extends StatefulWidget {
  TLDAAAPersonCenterHeaderView({Key key}) : super(key: key);

  @override
  _TLDAAAPersonCenterHeaderViewState createState() => _TLDAAAPersonCenterHeaderViewState();
}

class _TLDAAAPersonCenterHeaderViewState extends State<TLDAAAPersonCenterHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(168),bottom: ScreenUtil().setHeight(20)),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           _getUserInfoWidget(),
           Padding(
             padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
             child: Divider(height: ScreenUtil().setHeight(2),color: Colors.white),
           ),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child: Text('我的收益',style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white),),
           ),
           Padding(
             padding: EdgeInsets.only(top :ScreenUtil().setHeight(10)),
             child: Text('23892.23 TLD',style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Theme.of(context).hintColor),),
           ),
           _getAddressView(context),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child: Text('推荐人 weixin123',style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white),),
           ),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child : Container(
               height: ScreenUtil().setHeight(80),
               width: ScreenUtil.screenWidth - ScreenUtil().setWidth(60),
               child: CupertinoButton(
                 color: Theme.of(context).hintColor,
                 borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
                 child: Text('我要升级',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51))),
                 onPressed: (){

                 },
               ),
             )
           )
         ],
       ),
    );
  }

  Widget _getUserInfoWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _getUserHeaderWidget(),
        _getUserInfoColumnWidget(),
      
      ],
    );
  }

  Widget _getUserInfoColumnWidget(){
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('张三BAOBAO',style : TextStyle(fontSize : ScreenUtil().setSp(32),color : Colors.white)),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: RichText(
              text: TextSpan(
                children : <InlineSpan>[
                  WidgetSpan(
                    child : Icon(IconData(0xe61d,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24),),
                  ),
                  TextSpan(
                    text: '  weixin123   ',
                    style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white)
                  ),
                   WidgetSpan(
                    child : Icon(IconData(0xe605,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24)),
                  ),
                   TextSpan(
                    text: '  187 2192 7328',
                    style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white)
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getUserHeaderWidget(){
    return Stack(
      alignment: FractionalOffset(0.9, 0.9),
      children: <Widget>[
        Container(
          width : ScreenUtil().setHeight(96),
          height : ScreenUtil().setHeight(96),
          child : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(48)),
             child: CachedNetworkImage(imageUrl:'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600843055428&di=8429974600e80a8700e987ab57893a8c&imgtype=0&src=http%3A%2F%2Fpic43.photophoto.cn%2F20170506%2F0470102348231008_b.jpg',fit: BoxFit.fill,),
          )
        ),
        Container(
          width : ScreenUtil().setHeight(32),
          height : ScreenUtil().setHeight(32),
          child: CachedNetworkImage(imageUrl:'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3303266263,407158830&fm=26&gp=0.jpg',fit: BoxFit.fill,),
        )
      ],
    );
  }

  Widget _getAddressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        
      },
      child: Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Color.fromARGB(255, 82, 82, 82),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width - ScreenUtil().setWidth(190),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(36)),
            child: Text(
              '17dQNYkPb16G······re',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.white),
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
                  Icons.keyboard_arrow_right,
                  size: ScreenUtil().setWidth(32),
                  color: Colors.white,
                ),
                onPressed: () {}),
          )
        ],
      ),
    ),
    );
  }

}