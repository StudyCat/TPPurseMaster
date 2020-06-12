import 'package:dragon_sword_purse/Purse/Settings/Page/tld_purse_setting_backup_word_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../CommonWidget/dash_rect.dart';
import '../View/tld_verify_word_input_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_verify_word_gridview.dart';
import 'tld_purse_backup_word_success_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TLDVerifyWordPage extends StatefulWidget {
  TLDVerifyWordPage({Key key,this.words,this.type,this.verifySuccessCallBack}) : super(key: key);

  final List words;

  final TLDBackWordType type;

  final Function verifySuccessCallBack;

  @override
  _TLDVerifyWordPageState createState() => _TLDVerifyWordPageState();
}

class _TLDVerifyWordPageState extends State<TLDVerifyWordPage> {
  int currentSelectedIndex;

  List selectedWords;

  List radomList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedWords = [];
    
    radomList = List.from(widget.words);
    radomList.sort((a, b) => a.length.compareTo(b.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'verify_word_page',
        transitionBetweenRoutes: false,
        middle: Text('钱包设置'),
        trailing: GestureDetector(
          onTap:(){
            if (selectedWords.length > 0){
              int length = selectedWords.length;
            setState(() {
              selectedWords.removeAt(length - 1);
            });
            }
          },
          child : Text('撤回',style:TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28)))
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TLDVerifyWordInputCell(words: selectedWords,),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(60),left: ScreenUtil().setWidth(140),right: ScreenUtil().setWidth(140)),
            child: Text('从下面打乱的助记词中选择助记词填到上面的格子中',style : TextStyle(fontSize: ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51)),textAlign: TextAlign.center,),
          ),
          Container(height:180 ,child: TLDVerifyWordGridView(words: radomList,currentedIndex: currentSelectedIndex,didClickItem: (int index){
            if (selectedWords == null || selectedWords.length < 12){
              String word = radomList[index];
              if (!selectedWords.contains(word)){
                setState(() {
                  currentSelectedIndex = index;
                  selectedWords.add(radomList[index]);
                });
              }
            }
          },)),
          Container(
            width: size.width - ScreenUtil().setWidth(200),
            margin: EdgeInsets.only(top : ScreenUtil().setHeight(80)),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('下一步',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){
              if(selectedWords.length == 12){
                if(widget.words.toString() == selectedWords.toString()){
                  if (widget.type == TLDBackWordType.normal){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => TLDPurseBackupWordSuccessPage()));
                  }else if(widget.type == TLDBackWordType.delete){
                    widget.verifySuccessCallBack();
                    Navigator.of(context)..pop()..pop();
                  }
                }else{
                  Fluttertoast.showToast(
                        msg: "助记词备份错误",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
               }
              }else{
                 Fluttertoast.showToast(
                        msg: "需要备份12个助记词",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
              }
            }
            ), 
          ),
        ],
      );
  }
}