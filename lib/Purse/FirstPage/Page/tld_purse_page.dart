import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/message_button.dart';
import '../View/purse_first_cell.dart';
import '../View/purse_cell.dart';
import '../View/purse_bottom_cell.dart';
import '../View/purse_firstpage_sideslip.dart';

class TLDPursePage extends StatefulWidget {
  TLDPursePage({Key key}) : super(key: key);

  @override
  _TLDPursePageState createState() => _TLDPursePageState();
}

class _TLDPursePageState extends State<TLDPursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(),
      drawer: TLDPurseSideslipView(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        middle: Text('TLD钱包'),
        leading:Builder(builder: (BuildContext context){
          return CupertinoButton(
          child: Icon(IconData(0xe608,fontFamily: 'appIconFonts'),color: Color.fromARGB(255, 51, 51, 51),),
          padding: EdgeInsets.all(0),
          minSize: 20,
          onPressed: (){
            Scaffold.of(context).openDrawer();
          });
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(didClickCallBack : (){

        }),
      ),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemBuilder: (context,index) => _getListViewItem(index),
      itemCount: 5,
    );
  }

  Widget _getListViewItem(int index){
    if (index == 0){
      return TLDPurseHeaderCell();
    }else if (index == 4){
      return TLDPurseFirstPageBottomCell();
    }else{
      return TLDPurseFirstPageCell();
    }
  }

}