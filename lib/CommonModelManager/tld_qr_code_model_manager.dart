

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

enum QRCodeType{
  redEnvelope,
  transfer,
  inviteCode
}

class TLDQRcodeCallBackModel{
  var data;
  QRCodeType type;

  TLDQRcodeCallBackModel({this.data,this.type});
}

class TLDQRCodeModelManager{
  void scanQRCodeResult(String qrCode,Function success,Function failure){
    try{
    if (qrCode.contains('isTLD')){
      Uri url = Uri.parse(qrCode);
      if (url.queryParameters['codeType'] != null){
        QRCodeType type;
        if (int.parse(url.queryParameters['codeType']) == 1){
          type = QRCodeType.redEnvelope;
          if (url.queryParameters['redEnvelopeId'] != null){
            String redEnvelopeId = url.queryParameters['redEnvelopeId'];
            
            success(TLDQRcodeCallBackModel(data:redEnvelopeId,type: type));
          }else{
            TLDError error = TLDError(500,'无法识别的二维码');
            failure(error);
          }
        }else if (int.parse(url.queryParameters['codeType']) == 2){
          type = QRCodeType.transfer;
          if (url.queryParameters['walletAddress'] != null){
            String walletAddress = url.queryParameters['walletAddress'];
            
            success(TLDQRcodeCallBackModel(data:walletAddress,type: type));
          }else{
            TLDError error = TLDError(500,'无法识别的二维码');
            failure(error);
          }
        }else if (int.parse(url.queryParameters['codeType']) == 3){
           type = QRCodeType.inviteCode;
          if (url.queryParameters['inviteCode'] != null){
            String inviteCode = url.queryParameters['inviteCode'];
            
            success(TLDQRcodeCallBackModel(data:inviteCode,type: type));
          }else{
            TLDError error = TLDError(500,'无法识别的二维码');
            failure(error);
          }
        }
      }else{
        TLDError error = TLDError(500,'无法识别的二维码');
        failure(error);
      }
    }else{
      TLDError error = TLDError(500,'无法识别的二维码');
      failure(error);
    }
    }catch(e){
      TLDError error = TLDError(501,'识别二维码错误');
      failure(error);
    }
  }


}