import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDBuySearchField extends StatefulWidget {
  TLDBuySearchField({Key key}) : super(key: key);

  @override
  _TLDBuySearchFieldState createState() => _TLDBuySearchFieldState();
}

class _TLDBuySearchFieldState extends State<TLDBuySearchField> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 10 ,right: 15),
       width: screenSize.width - 30,
       height: 50,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           padding: EdgeInsets.only(left:10,right: 10),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               Container(
                 width: screenSize.width - 115,
                 child: TextField(
                   decoration : InputDecoration(
                     border : InputBorder.none,
                     hintText: '请输入TLD数量',
                     hintStyle: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: 12),
                     ),
                   style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: 12),
                 ),
               ),
               Container(height: 5, child: VerticalDivider(color: Color.fromARGB(255, 187, 187, 187))),
               Container(
                 padding: EdgeInsets.only(left : 5),
                 width: 45,
                 height: 30,
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),
                   child: Text('查询',style : TextStyle(fontSize : 14 , color : Color.fromARGB(255, 51, 114, 245)),),
                   onPressed: (){
                      
                   }),
               ),
             ],
           )
         ),
       ),
    );
  }
}