import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance-sign_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_body_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_header_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_tab_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAcceptanceSignPage extends StatefulWidget {
  TLDAcceptanceSignPage({Key key}) : super(key: key);


  @override
  _TLDAcceptanceSignPageState createState() => _TLDAcceptanceSignPageState();
}

class _TLDAcceptanceSignPageState extends State<TLDAcceptanceSignPage> with AutomaticKeepAliveClientMixin {
  TLDAcceptanceSignModelManager _modelManager;

  bool _isLoading = false;

  TLDAcceptanceUserInfoModel _userInfoModel;
  @override
  void initState() { 
    super.initState();
    
    _modelManager = TLDAcceptanceSignModelManager();
    _getUserInfo();
  }

  void _getUserInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getUserInfo((TLDAcceptanceUserInfoModel userInfoModel){
      if(mounted){
              setState(() {
      _isLoading = false;
      _userInfoModel = userInfoModel;
    });
      }
    }, (TLDError error){
      if(mounted){
              setState(() {
      _isLoading = false;
    });
      }
    Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _changeWallet(TLDWalletInfoModel infoModel){
        setState(() {
      _isLoading = true;
    });
    _modelManager.changeWallet(infoModel.walletAddress, (){
      if(mounted){
        setState(() {
          _isLoading = false;
          _userInfoModel.walletAddress = infoModel.walletAddress;
          _userInfoModel.wallet = infoModel.wallet;
        });
      }
    }, (TLDError error){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _sign(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.sign((){
      if(mounted){
               setState(() {
      _isLoading = false;
    });
      }
    _getUserInfo();
    }, (TLDError error){
      if(mounted){
               setState(() {
      _isLoading = false;
    });
      }
    Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_sign_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑账户',style: TextStyle(color:Colors.white),),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
        trailing: GestureDetector(
          onTap :(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceWithdrawTabPage()));
          },
          child : Text('提现记录',style: TextStyle(color:Colors.white,))
        ),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBody(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        TLDAcceptanceSignHeaderView(userInfoModel: _userInfoModel,didClickLoginCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceLoginPage()));
        },
        didClickWithdrawButtonCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceWithdrawPage(walletAddress: _userInfoModel.walletAddress,)));
        },
        ),
        TLDAcceptanceSignBodyView(userInfoModel: _userInfoModel,didClickSignButton: (){
          _sign();
        },
        didClickWalletButton: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDEchangeChooseWalletPage(
            didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
              _changeWallet(infoModel);
            },
          )));
        },)
      ],
    );
  }

  Widget _getBody(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          color: Theme.of(context).primaryColor,
        ),
        _getBodyWidget()
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}