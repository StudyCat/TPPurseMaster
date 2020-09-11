import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_wallet_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Page/tld_transfer_accounts_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Purse/FirstPage/View/purse_cell.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';
import '../Model/tld_exchange_choose_wallet_model_manager.dart';

enum TLDEchangeChooseWalletPageType{
  normal,
  transfer
}

class TLDEchangeChooseWalletPage extends StatefulWidget {
  TLDEchangeChooseWalletPage({Key key,this.didChooseWalletCallBack,this.type = TLDEchangeChooseWalletPageType.normal,this.transferWalletAddress,this.transferAmount}) : super(key: key);

  final Function(TLDWalletInfoModel) didChooseWalletCallBack;

  final TLDEchangeChooseWalletPageType type;

  final String transferWalletAddress;

  final String transferAmount;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController.close();
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
        middle: Text(I18n.of(context).chooseWallet),
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
          if (widget.type == TLDEchangeChooseWalletPageType.normal){
            widget.didChooseWalletCallBack(model);
            Navigator.of(context).pop();
          }else {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDTransferAccountsPage(type: TLDTransferAccountsPageType.fromOtherPage,thirdAppFromWalletAddress: model.walletAddress,thirdAppToWalletAddress: widget.transferWalletAddress,)));
          }
        },);
  }

  void getWalletList(){
    _modelManager.getWalletListData(false,(List infoList) {
        _dataSource = List.from(infoList);
        if (mounted){
          _streamController.sink.add(_dataSource);
        }
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }
}