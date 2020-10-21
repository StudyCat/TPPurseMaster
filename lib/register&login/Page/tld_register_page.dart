
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/register&login/Model/tld_register_model_manager.dart';
import 'package:dragon_sword_purse/register&login/Page/tld_register_invite_code_page.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_bottom_cell.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_header_cell.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_input_cell.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_verify_code_cell.dart';
import 'package:dragon_sword_purse/tld_not_purse_page.dart';
import 'package:dragon_sword_purse/tld_tabbar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TLDRegisterView extends StatefulWidget {
  TLDRegisterView({Key key}) : super(key: key);

  @override
  _TLDRegisterViewState createState() => _TLDRegisterViewState();
}

class _TLDRegisterViewState extends State<TLDRegisterView> {
  TLDRegisterPramater _pramater;

  TLDRegisterModelManager _modelManager;

  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getPurseList();

    _pramater = TLDRegisterPramater();

    _modelManager = TLDRegisterModelManager();
  }

  void _getPurseList() async{
    TLDDataBaseManager manager = TLDDataBaseManager();
     await manager.openDataBase();
     List allPurse = await manager.searchAllWallet();
    await manager.closeDataBase();
    allPurse == null ? TLDDataManager.instance.purseList = [] : TLDDataManager.instance.purseList = List.from(allPurse);
  }

  void _sendTelCode()async{
    bool isHavePermission = await MobileNumber.hasPhonePermission;
    if (!isHavePermission){
      await MobileNumber.requestPhonePermission;
      return;
    }

    try{
    List<SimCard> simCards = await MobileNumber.getSimCards;
     bool haveNumber = false;
     for (SimCard simcard in simCards) {
       if (simcard.number.contains(_pramater.tel)){
         haveNumber = true;
         _pramater.mobileOperators = simcard.carrierName;
       }
     }
     if (haveNumber == false){
       Fluttertoast.showToast(msg: '此设备非法，请更换设备');
      return;
     }

    setState(() {
      _isLoading = true;
    });
    _modelManager.getMessageCode(_pramater.tel, (){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '获取验证码成功，请留意短信或者电话');
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg);
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
    });
    }catch(e){
      Fluttertoast.showToast(msg: '此设备非法，请更换设备');
    }
  }

  void _register() {
    if (_pramater.tel == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterYourCellPhoneNumber);
      return;
    } 
    if (_pramater.telCode == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterVerifyCode);
      return;
    }
    if (_pramater.telCode == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterYourNickName);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _modelManager.register(_pramater, (String token) async {
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      TLDDataManager.instance.acceptanceToken = token;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('acceptanceToken', token);
      if (TLDDataManager.instance.purseList.length > 0){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => TLDTabbarPage()), (route) => route == null);
      }else{
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => TLDNotPurseHomePage()), (route) => route == null);
      }
    }, (TLDError error){
       if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
     if (error.code == -3){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TLDRegisterInviteCodePage(pramater: _pramater,)));
     }else{
        Fluttertoast.showToast(msg: error.msg);
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'register_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).register),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TLDRegisterHeaderCell();
      }else if(index < 3){
        String placeholder;
        if (index == 1){
          placeholder = I18n.of(context).pleaseEnterYourCellPhoneNumber;
        }else{
          placeholder = I18n.of(context).pleaseEnterYourNickName;
        }
        return TLDRegisterInputCell(placeHolder : placeholder,index: index,textDidChangeCallBack: (String text,int index){
          if (index == 1){
            _pramater.tel = text;
          }else{
            _pramater.nickname = text;
          }
        },);
      }else if (index == 3){
        return TLDRegisterVerifyCodeCell(didClickSendCodeBtnCallBack: (){
          _sendTelCode();
        },codeDidChangeCallBack: (str){
          _pramater.telCode = str;
        },
        );
      }
      return TLDRegisterBottomCell(
        didClickNextCallBack: (){
          _register();
        },
      );
     },
    );
  }



}