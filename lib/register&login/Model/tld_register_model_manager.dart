

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLDRegisterPramater {
  String inviteCode;
  String tel;
  String telCode;
  String nickname;
}

class TLDRegisterModelManager{

  void register(TLDRegisterPramater pramater,Function success,Function failure){
    Map pramaterMap = {'code':pramater.telCode,'nickName':pramater.nickname,'tel':pramater.tel};
    if (pramater.inviteCode != null){
      pramaterMap.addEntries({'inviteCode' : pramater.inviteCode}.entries);
    }
    TLDBaseRequest request = TLDBaseRequest(pramaterMap,'tldUser/registerTldUser');
    request.postNetRequest((value) async {
      String token = value['jwtToken'];
      success(token);
    }, (error) => failure(error));
  }

    void getMessageCode(String cellPhoneNum,
      Function() success, Function(TLDError) failure) {
    TLDBaseRequest request = TLDBaseRequest(
        {'tel': cellPhoneNum},
        'common/getRegisterTelCode');
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