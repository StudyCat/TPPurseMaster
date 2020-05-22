import 'dart:async';

import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_success_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tld_create_purse_success_page.dart';
import '../Model/create_purse_model_manager.dart';
import '../../../Notification/tld_import_create_purse_success_notification.dart';
import '../../../CommonWidget/tld_data_manager.dart';

enum TLDCreatingPursePageType { create, import }

class TLDCreatingPursePage extends StatefulWidget {
  TLDCreatingPursePage(
      {Key key, @required this.type, this.mnemonicString, this.privateKey})
      : super(key: key);

  final TLDCreatingPursePageType type;

  final String mnemonicString;

  final String privateKey;

  @override
  _TLDCreatingPursePageState createState() => _TLDCreatingPursePageState();
}

class _TLDCreatingPursePageState extends State<TLDCreatingPursePage> {
  TLDCreatePurseModelManager _manager;
  @override
  void initState() {
    super.initState();

    _manager = TLDCreatePurseModelManager();
    Future.delayed(Duration(seconds: 1), () {
      if (widget.type == TLDCreatingPursePageType.create) {
        _createPurse();
      } else {
        if (widget.mnemonicString != null) {
          _importPurseWithWord();
        } else {}
      }
    });
  }

  void _createPurse() async {
    await _manager.createPurse('', (TLDWallet wallet) {
      TLDDataManager.instance.purseList.add(wallet);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TLDCreatePurseSuccessPage(
                    wallet: wallet,
                  )));
    });
  }

  void _importPurseWithWord() async {
    await _manager.importPurseWithWord(widget.mnemonicString,
        (TLDWallet wallet) {
      TLDDataManager.instance.purseList.add(wallet);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TLDImportPurseSuccessPage()));
    }, () {
      Fluttertoast.showToast(
          msg: '已拥有该钱包',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
      Navigator.popAndPushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.type == TLDCreatingPursePageType.create) {
      title = '创建钱包';
    } else {
      title = '导入钱包';
    }
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'creating_purse_page',
        transitionBetweenRoutes: false,
        middle: Text(title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    String str;
    if (widget.type == TLDCreatingPursePageType.create) {
      str = '钱包创建中，请您耐心等待……';
    } else {
      str = '钱包导入中，请您耐心等待……';
    }
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
          child: Image.asset(
            'assetss/images/creating_purse.png',
            width: ScreenUtil().setWidth(176),
            height: ScreenUtil().setHeight(212),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text(str,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        )
      ],
    ));
  }
}
