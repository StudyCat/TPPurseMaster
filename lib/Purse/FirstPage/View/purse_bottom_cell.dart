import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDPurseFirstPageBottomCell extends StatefulWidget {
  TLDPurseFirstPageBottomCell({Key key}) : super(key: key);

  @override
  _TLDPurseFirstPageBottomCellState createState() => _TLDPurseFirstPageBottomCellState();
}

class _TLDPurseFirstPageBottomCellState extends State<TLDPurseFirstPageBottomCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child :Container(
           color: Colors.white,
           padding: EdgeInsets.only(top : 13 ,left :12 ,right :12 , bottom :20),
           width: screenSize.width - 34,
           child: Text('温馨提示：\n      冷钱包创建在手机端本地。创建钱包会要求您输入钱包密码，钱包会生成您用来恢复钱包的助记词，签名用的私钥，加密和验签用的公钥，以及钱包地址。\n      请妥善保管好您的助记词和私钥',style :TextStyle(fontSize : 12 ,color: Color.fromARGB(255, 153, 153, 153))),
         ),
       ),
    );
  }
}