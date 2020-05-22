import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/message_button.dart';
import '../View/purse_first_cell.dart';
import '../View/purse_cell.dart';
import '../View/purse_bottom_cell.dart';
import '../../MyPurse/Page/tld_my_purse_page.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import '../../../ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Message/Page/tld_message_page.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../CommonFunction/tld_common_function.dart';

class TLDPursePage extends StatefulWidget {
  TLDPursePage({Key key,this.didClickMoreBtnCallBack}) : super(key: key);
  final Function didClickMoreBtnCallBack;

  @override
  _TLDPursePageState createState() => _TLDPursePageState();
}

class _TLDPursePageState extends State<TLDPursePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TLDMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(didClickCallBack: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDMessagePage()));
        }),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _getListViewItem(context,index),
      itemCount: TLDDataManager.instance.purseList.length + 2,
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
    if (index == 0) {
      return TLDPurseHeaderCell(
        didClickCreatePurseButtonCallBack: (){
          _createPurse(context);
        },
        didClickImportPurseButtonCallBack: (){
          _importPurse(context);
        },
        );
    } else if (index == TLDDataManager.instance.purseList.length + 1) {
      return TLDPurseFirstPageBottomCell();
    } else {
      TLDWallet wallet = TLDDataManager.instance.purseList[index - 1];
      return TLDPurseFirstPageCell(
        wallet: wallet,
        didClickCallBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  TLDMyPursePage(wallet: wallet,changeNameSuccessCallBack: (String name){
                  setState(() {
                    TLDDataManager.instance.purseList;
                  });
                },);
              },
            ),
          );
        },
      );
    }
  }

  void _createPurse(BuildContext context){
    jugeHavePassword(context, (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDCreatingPursePage(type: TLDCreatingPursePageType.create,)));
    },TLDCreatePursePageType.create,null);
  }

  void _importPurse(BuildContext context){
    jugeHavePassword(context,(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDImportPursePage()));
    },TLDCreatePursePageType.import,null);
  }
  
}
