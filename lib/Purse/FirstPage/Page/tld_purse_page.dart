import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/message_button.dart';
import '../View/purse_first_cell.dart';
import '../View/purse_cell.dart';
import '../View/purse_bottom_cell.dart';
import '../View/purse_firstpage_sideslip.dart';
import '../../MyPurse/Page/tld_my_purse_page.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import '../../../ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import '../../../Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';

class TLDPursePage extends StatefulWidget {
  TLDPursePage({Key key}) : super(key: key);

  @override
  _TLDPursePageState createState() => _TLDPursePageState();
}

class _TLDPursePageState extends State<TLDPursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(context),
      drawer: TLDPurseSideslipView(
        didClickCallBack: (int index){
          if (index == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDChoosePaymentPage()));
          }
        },
      ),
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
                Scaffold.of(context).openDrawer();
              });
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(didClickCallBack: () {}),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _getListViewItem(context,index),
      itemCount: 5,
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
    if (index == 0) {
      return TLDPurseHeaderCell(
        didClickCreatePurseButtonCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDCreatePursePage()));
        },
        didClickImportPurseButtonCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDImportPursePage()));
        },
        );
    } else if (index == 4) {
      return TLDPurseFirstPageBottomCell();
    } else {
      return TLDPurseFirstPageCell(
        didClickCallBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  TLDMyPursePage();
              },
            ),
          );
        },
      );
    }
  }
}
