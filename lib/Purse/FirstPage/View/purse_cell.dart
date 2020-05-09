import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDPurseFirstPageCell extends StatefulWidget {
  TLDPurseFirstPageCell({Key key,this.didClickCallBack}) : super(key: key);
  final Function didClickCallBack;
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
           child: Row(
             mainAxisAlignment : MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 padding : EdgeInsets.only(top : 10,left: 0),
                 width: 36,
                 height: 36,
                 child: Image.asset('assetss/images/home_purse_icon.png'),
               ),
                Container(
                  padding: EdgeInsets.only(left : 10,top: 0,bottom: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('我的钱包',style : TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: 14),),
                      Container(
                        padding: EdgeInsets.only(top : 8,right: 15),
                        child: Text('100.00TLD',style: TextStyle(color: Color.fromARGB(255, 51, 114, 245),fontSize: 18),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top : 4,right: 15),
                        child: Text('=100.00rmb',style: TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: 12),),
                      )
                    ],
                  ),
                )
             ],
           ),
         ),
       ),
    )
    );
  }
}