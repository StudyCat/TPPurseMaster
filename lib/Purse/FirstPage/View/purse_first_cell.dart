import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDPurseHeaderCell extends StatefulWidget {
  TLDPurseHeaderCell({Key key,this.didClickCreatePurseButtonCallBack,this.didClickImportPurseButtonCallBack}) : super(key: key);

  final Function didClickCreatePurseButtonCallBack;
  final Function didClickImportPurseButtonCallBack;

  @override
  _TLDPurseHeaderCellState createState() => _TLDPurseHeaderCellState();
}

class _TLDPurseHeaderCellState extends State<TLDPurseHeaderCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; 
    return Container(
      padding: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 5),
      width: screenSize.width - 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('总积分',style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: 12),),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: screenSize.width - 70,
                child: Text('5653654656',style : TextStyle(fontSize : 26,color : Color.fromARGB(255,51, 114, 255))),
              ),
              Container(
                width: 20,
                height: 12,
                padding : EdgeInsets.only(right : 0,left: 10),
                child: CupertinoButton(
                  child: Icon(IconData(0xe60c,fontFamily: 'appIconFonts'),color: Color.fromARGB(255, 51, 114, 255),),
                  padding: EdgeInsets.all(0),
                  onPressed: (){},
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.only(left : 0 ,top : 6),
            child: Text('1.00TLD=1.00rmb',style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: 12),),
          ),

          Container(
            padding: EdgeInsets.only(top : 10),
            height: 40,
            child: Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getButton(()=>widget.didClickCreatePurseButtonCallBack(), '创建钱包', screenSize.width),
                getButton(()=>widget.didClickImportPurseButtonCallBack(), '导入钱包', screenSize.width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getButton(Function didClickCallBack,String title, double scrrenWidth){
      return Container(
                 width : scrrenWidth / 2.0 - 30,
                  child: RaisedButton(
                  color: Color.fromARGB(255,51, 114, 255),
              onPressed: () => didClickCallBack(),
                  child: ClipRRect(
           borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  child: Container(
                    child : Text(
                           title,
                           textAlign: TextAlign.center,
                           style : TextStyle(color: Colors.white,fontSize: 14)),
                      ),
                  ),
                    ), 
                );
  } 
}