import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDAcceptanceInvitationQRCodeModelManager {
  void getQrCodeInfo(Function(String,String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({}, 'acpt/user/userInviteCode');
    request.postNetRequest((value) {
      Map data = value;
      String inviteCode = data['inviteCode'];
      String userName = data['userName'];
      String qrCode = data['inviteQrCode'];
      success(qrCode,inviteCode);
    }, (error) => failure(error));
  }
}