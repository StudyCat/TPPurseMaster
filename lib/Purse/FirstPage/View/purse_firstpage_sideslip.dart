import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'purse_sideslip_header_cell.dart';


class TLDPurseSideslipView extends StatelessWidget {
  const TLDPurseSideslipView({Key key,this.didClickCallBack}) : super(key: key);

  final ValueChanged<int> didClickCallBack;

  @override
  Widget build(BuildContext context) {
    List iconList = [0xe83d,0xe641,0xe672,0xe8ac,0xe665,0xe60e];
    List titleList = ['安全中心','收款方式','积分兑换说明','反馈','关于我们','用户协议'];
    return Drawer(
      child: Scaffold(
        body: ListView.builder(
      itemCount: iconList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return TLDPurseSideSlipHeaderCell();
        }else{
          return ListTile(
            leading : Container(
              padding : EdgeInsets.only(left: 35),
              child: Icon(IconData(iconList[index - 1],fontFamily: 'appIconFonts'),color: Color.fromARGB(255,51, 114, 255),),
            ),
            title: Text(titleList[index - 1],style : TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: 14),textAlign: TextAlign.left,),
            onTap: (){
              this.didClickCallBack(index);
            },
          );
        }
     },
      ),
    ),
    );
  }
}