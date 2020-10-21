import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_sign_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_body_view.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';


class TLDAcceptanceSignSonPage extends StatefulWidget {
  TLDAcceptanceSignSonPage({Key key,this.userInfo}) : super(key: key);

  // final TLDAcceptanceUserInfoModel userInfoModel;

  final TLDAAAUserInfo userInfo;

  @override
  _TLDAcceptanceSignSonPageState createState() => _TLDAcceptanceSignSonPageState();
}

class _TLDAcceptanceSignSonPageState extends State<TLDAcceptanceSignSonPage> {
    TLDAcceptanceSignModelManager _modelManager;

    bool _isLoading = false;
    
    TLDAAAUserInfo _userInfoModel;
    @override
    void initState() { 
      super.initState();
      
      _userInfoModel = widget.userInfo;

      _modelManager = TLDAcceptanceSignModelManager();
    }

    
  void _getUserInfo(){
    _modelManager.getAAAUserInfo((TLDAAAUserInfo userInfoModel){
      if(mounted){
      setState(() {
       _userInfoModel = userInfoModel;
      });
      }
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg);
    });
  }

    void _sign(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.sign((String alert){
      if(mounted){
               setState(() {
      _isLoading = false;
    });
      }
    showDialog(
      context: context,
      builder: (context) => TLDAlertView(alertString: alert,title: '签到成功',didClickSureBtn: (){
        _getUserInfo();
      },),
      );
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
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'sign_son_page',
        transitionBetweenRoutes: false,
        trailing: GestureDetector(
          child: Text('签到记录'),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => TLDSignListPage()
            ));
          },
        ),
        middle: Text(I18n.of(context).signIn),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return SingleChildScrollView(
      child :   TLDAcceptanceSignBodyView(userInfoModel: _userInfoModel,didClickSignButton: (){
          _sign();
        },
        didClickWalletButton: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDEchangeChooseWalletPage(
            didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
            },
          )));
        }
    ));
  }

}