

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLDRegisterPramater {
  String inviteCode;
  String tel;
  String telCode;
  String nickname;
  String mobileOperators;
}

class TLDRegisterModelManager{

  void register(TLDRegisterPramater pramater,Function success,Function failure){
    String registerId = TLDDataManager.instance.registrationID;
    String password = TLDDataManager.instance.password;
    TLDWallet wallet = TLDDataManager.instance.purseList.first;
    Map pramaterMap = {'code':pramater.telCode,'nickName':pramater.nickname,'registrationId' : registerId,'password' : password,'tel':pramater.tel,'type' : wallet.type,'walletAddress' : wallet.address};
    if (pramater.inviteCode != null){
      pramaterMap.addEntries({'inviteCode' : pramater.inviteCode}.entries);
    }
    if (pramater.mobileOperators != null){
      pramaterMap.addEntries({'mobileOperators' : pramater.mobileOperators}.entries);
    }
    TLDBaseRequest request = TLDBaseRequest(pramaterMap,'tldUser/registerTldUser');
    request.postNetRequest((value) async {
      String token = value['jwtToken'];

      String userToken = value['token'];
      String username = value['imUserName'];
      SharedPreferences perference = await SharedPreferences.getInstance();
      perference.setString('userToken',userToken);
      TLDDataManager.instance.userToken = userToken;
      perference.setString('username', username);

      success(token);
    }, (error) => failure(error));
  }

    void getMessageCode(String cellPhoneNum,
      Function() success, Function(TLDError) failure) {
    TLDWallet wallet = TLDDataManager.instance.purseList.first;
    TLDBaseRequest request = TLDBaseRequest(
        {'tel': cellPhoneNum,'walletAddress' : wallet.address},
        'common/getRegisterTelCode');
    request.isNeedSign = true;
    request.walletAddress = wallet.address;
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

    void getInvationCodeFromQrCode(
      String qrCode, Function(String) success, Function(TLDError) failure) {
    if (qrCode.contains('http://www.tldollar.com')) {
      if (qrCode.contains('inviteCode')) {
        Uri uri = Uri.parse(qrCode);
        String walletAddress = uri.queryParameters['inviteCode'];
        success(walletAddress);
      } else {
        TLDError error = TLDError(1000, '未知的二维码');
        failure(error);
      }
    } else if (qrCode.contains('isTLD')) {
      Uri url = Uri.parse(qrCode);
      if (url.queryParameters['codeType'] != null) {
        if (int.parse(url.queryParameters['codeType']) == 3) {
          if (url.queryParameters['inviteCode'] != null) {
            String inviteCode = url.queryParameters['inviteCode'];
            success(inviteCode);
          } else {
            TLDError error = TLDError(500, '无法识别的二维码');
            failure(error);
          }
        }
      } else {
        TLDError error = TLDError(500, '无法识别的二维码');
        failure(error);
      }
    } else {
      TLDError error = TLDError(1000, '未知的二维码');
      failure(error);
    }
  }

}