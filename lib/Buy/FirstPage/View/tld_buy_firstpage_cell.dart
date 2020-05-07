import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_buy_button.dart';

class TLDBuyFirstPageCell extends StatefulWidget {
  TLDBuyFirstPageCell({Key key}) : super(key: key);

  @override
  _TLDBuyFirstPageCellState createState() => _TLDBuyFirstPageCellState();
}

class _TLDBuyFirstPageCellState extends State<TLDBuyFirstPageCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; 
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           width: screenSize.width - 30,
           padding: EdgeInsets.only(top : 10,bottom : 17),
           child: Column(
             children : <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(left : 10),
                     width: screenSize.width - 94,
                     child: Text('地址：fwefwefewfwefwef',style : TextStyle(fontSize : 12 ,color : Color.fromARGB(255, 153, 153, 153))),
                   ),
                   picAndTextButton('assetss/images/firspage_buy.png', '购买', (){})
                 ],
               ),
             ]
           ),
         ),
       ),
    );
  }
}