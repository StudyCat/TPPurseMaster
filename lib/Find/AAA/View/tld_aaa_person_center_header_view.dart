
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAAAPersonCenterHeaderView extends StatefulWidget {
  TLDAAAPersonCenterHeaderView({Key key,this.didClickUpgradeButtonCallBack,this.userInfo}) : super(key: key);

  final Function didClickUpgradeButtonCallBack;

  final TLDAAAUserInfo userInfo;

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
             child: Text(widget.userInfo != null ? '${widget.userInfo.totalProfit} TLD' : '0 TLD',style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Theme.of(context).hintColor),),
           ),
           _getAddressView(context),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child: Text(widget.userInfo != null ? '推荐人 ${widget.userInfo.inviteWechat}' : '推荐人',style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white),),
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
                   widget.didClickUpgradeButtonCallBack();
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
          Text(widget.userInfo != null ? widget.userInfo.nickName : '',style : TextStyle(fontSize : ScreenUtil().setSp(32),color : Colors.white)),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: RichText(
              text: TextSpan(
                children : <InlineSpan>[
                  WidgetSpan(
                    child : Icon(IconData(0xe61d,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24),),
                  ),
                  TextSpan(
                    text: widget.userInfo != null ? '  ${widget.userInfo.nickName}   ' : '     ',
                    style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white)
                  ),
                   WidgetSpan(
                    child : Icon(IconData(0xe605,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24)),
                  ),
                   TextSpan(
                    text: widget.userInfo != null ? '  ${widget.userInfo.tel}' : "  ",
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
             child: Image.asset('assetss/images/aaa_user_header.png',fit: BoxFit.fill,),
          )
        ),
        Container(
          width : ScreenUtil().setHeight(32),
          height : ScreenUtil().setHeight(32),
          child: widget.userInfo != null ? CachedNetworkImage(imageUrl:widget.userInfo.levelIcon,fit: BoxFit.fill,) : Container(),
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
              widget.userInfo != null ? widget.userInfo.walletAddress : '',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.white),
            ),
          )
        ],
      ),
    ),
    );
  }

}