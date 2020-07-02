import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/tld_wallet_info_model.dart';

class TLDPurseFirstPageCell extends StatefulWidget {
  TLDPurseFirstPageCell({Key key,this.didClickCallBack,this.walletInfo}) : super(key: key);
  final Function didClickCallBack;
  final TLDWalletInfoModel walletInfo;
  @override
  _TLDPurseFirstPageCellState createState() => _TLDPurseFirstPageCellState();
}

class _TLDPurseFirstPageCellState extends State<TLDPurseFirstPageCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap : () => widget.didClickCallBack(),
      child : Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           padding: EdgeInsets.only(top : 9 ,left:10,right: 10),
           child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     _getWalletNameRowView(),
                      Container(
                        padding: EdgeInsets.only(top : 8,right: 15),
                        child: Text(double.parse(widget.walletInfo.value).toStringAsFixed(2)+'TLD',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top : 4,right: 15,bottom: 10),
                        child: Text('='+double.parse(widget.walletInfo.value).toStringAsFixed(2)+'CNY',style: TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: 12),),
                      )
                    ],
                  ),
         ),
       ),
    )
    );
  }

  Widget _getWalletNameRowView(){
    Size size = MediaQuery.of(context).size;
    return  Container(
        width : size.width - 30,
        child : Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(widget.walletInfo.wallet.name,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
          Padding(
            padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
            child: RichText(text: TextSpan(children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: widget.walletInfo.levelIcon,width: ScreenUtil().setWidth(24),height: ScreenUtil().setWidth(24),),),
            TextSpan(text :widget.walletInfo.expProgress,style:TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51)))
          ])),
          )
        ],
      )
    );
  }
}