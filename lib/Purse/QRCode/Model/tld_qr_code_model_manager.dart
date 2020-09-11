


import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDQrCodeModelManager{
  void getTransferQrCode(String walletAddress,Function(String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAddress' : walletAddress},'wallet/getTransferQrCode');
    request.postNetRequest((value) {
      String qrCode = value['transferQrCode'];
      success(qrCode);
    }, (error) => failure(error));
  }
}