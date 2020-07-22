import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLDAcceptanceLoginPramater{
  String inviteCode;
  String tel;
  String telCode;
  String walletAddress;
}

class TLDAcceptanceLoginModelManager{
  void getMessageCode(String cellPhoneNum,Function() success ,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'tel':cellPhoneNum}, 'common/getRegisterTelCode');
    request.postNetRequest((value) { 
      success();
    }, (error) => failure(error));
  }

  void loginWithPramater(TLDAcceptanceLoginPramater pramater,Function(String) suceess,Function(TLDError) failure){
    String imUserName = TLDDataManager.instance.username;
     TLDBaseRequest request = TLDBaseRequest({'tel':pramater.tel,'inviteCode':pramater.inviteCode,'telCode':pramater.telCode,'walletAddress':pramater.walletAddress,'TLDUserName':imUserName}, 'acpt/user/registerAcptUser');
    request.postNetRequest((value) async {
      String token = value['jwtToken'];
      TLDDataManager.instance.acceptanceToken = token;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('acceptanceToken', token); 
      suceess(token);
    }, (error) => failure(error));
  }

  void getInvationCodeFromQrCode(String qrCode,Function(String) success,Function(TLDError) failure){
     if(qrCode.contains('http://www.tlddollar.com')){
        if (qrCode.contains('inviteCode')){
          Uri uri = Uri.parse(qrCode);
          String walletAddress = uri.queryParameters['inviteCode'];
          success(walletAddress);
        }else{
          TLDError error = TLDError(1000,'未知的二维码');
          failure(error);
        }
      }else{
        TLDError error = TLDError(1000,'未知的二维码');
        failure(error);
      }
  }

}