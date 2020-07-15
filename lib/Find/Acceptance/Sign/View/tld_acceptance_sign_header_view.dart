import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceSignHeaderView extends StatefulWidget {
  TLDAcceptanceSignHeaderView({Key key}) : super(key: key);

  @override
  _TLDAcceptanceSignHeaderViewState createState() => _TLDAcceptanceSignHeaderViewState();
}

class _TLDAcceptanceSignHeaderViewState extends State<TLDAcceptanceSignHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
       child: Container(
         padding: EdgeInsets.only(left:ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
         decoration: BoxDecoration(
           borderRadius : BorderRadius.all(Radius.circular(4)),
           color : Colors.white
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children:<Widget>[
             Padding(padding: EdgeInsets.only(top:ScreenUtil().setWidth(20)),
             child: _getTopRowWidget(),),
             _getAmountWidget()
           ]
         ),
       ),
    );
  }

  Widget _getTopRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getTopLeftRowWidget(),
        Container(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(130),
          child: CupertinoButton(
            child: Text('去登记',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Theme.of(context).hintColor)),
            padding: EdgeInsets.zero,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
            onPressed: (){},
          ),
        )
      ],
    );
  }

  Widget _getTopLeftRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset('assetss/images/icon_sale.png',width: ScreenUtil().setHeight(60),height: ScreenUtil().setHeight(60),fit: BoxFit.cover,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : <Widget>[
            _getUserInfoWidget(0xe6b3, '2313123213'),
            Padding(padding: EdgeInsets.only(top : ScreenUtil().setHeight(4),),child: _getUserInfoWidget(0xe605, '231231231231221'),),
          ]
        )
      ],
    );
  }

  Widget _getUserInfoWidget(int iconCode,String content){
    return RichText(
              text: TextSpan(
                children : <InlineSpan>[
                  WidgetSpan(child: Icon(IconData(iconCode,fontFamily: 'appIconFonts'),size: ScreenUtil().setHeight(24),color: Color.fromARGB(255, 153, 153, 153),)),
                  TextSpan(text :'  ' + content,style:TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize:ScreenUtil().setSp(24)))
                ]
              )
            );
  }

  Widget _getAmountWidget(){
    return Padding(
      padding: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
      child: RichText(text: TextSpan(
        text : '328932.32',
        style : TextStyle(
          fontSize:ScreenUtil().setSp(72),
          fontWeight : FontWeight.bold,
          color : Color.fromARGB(255, 51, 51, 51)
        ),
        children: <InlineSpan>[
          TextSpan(
        text : '   积分',
        style : TextStyle(
          fontSize:ScreenUtil().setSp(24),
          color : Color.fromARGB(255, 153, 153, 153)
        ),)
        ]
      ),
      ),
    );
  }

}