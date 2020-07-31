import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_wallet_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Purse/FirstPage/View/purse_cell.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';
import '../Model/tld_exchange_choose_wallet_model_manager.dart';

class TLDEchangeChooseWalletPage extends StatefulWidget {
  TLDEchangeChooseWalletPage({Key key,this.didChooseWalletCallBack}) : super(key: key);

  final Function(TLDWalletInfoModel) didChooseWalletCallBack;

  @override
  _TLDEchangeChooseWalletPageState createState() => _TLDEchangeChooseWalletPageState();
}

class _TLDEchangeChooseWalletPageState extends State<TLDEchangeChooseWalletPage> {

  List _dataSource = [];

  StreamController _streamController;

  TLDExchangeChooseWalletModelManager _modelManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDExchangeChooseWalletModelManager();
    
    getWalletList();

    _streamController = StreamController();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_choose_purse_page',
        transitionBetweenRoutes: false,
        middle: Text('选择钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

    Widget _getBodyWidget(BuildContext context) {
    return TLDEmptyListView(
      streamController: _streamController,
      getEmptyViewCallBack: (){
        return TLDEmptyWalletView();
      },
      getListViewCellCallBack: (int index){
        return _getListViewItem(context,index);
      },
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
      TLDWalletInfoModel model = _dataSource[index];
      return TLDPurseFirstPageCell(
        walletInfo: model,
        didClickCallBack: () {
          widget.didChooseWalletCallBack(model);
          Navigator.of(context).pop();
        },);
  }

  void getWalletList(){
    _modelManager.getWalletListData(false,(List infoList) {
        _dataSource = List.from(infoList);
        _streamController.sink.add(_dataSource);
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }
}