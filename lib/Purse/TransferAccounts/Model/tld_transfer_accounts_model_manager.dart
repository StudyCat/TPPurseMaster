
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDTranferAmountPramaterModel{
  String chargeValue;
  String chargeWalletAddress;
  String fromWalletAddress;
  String toWalletAddress;
  String value; 
}

class TLDTransferAccountsModelManager{

    void getAddressFromQrCode(String qrCode,Function(String) success,Function(TLDError) failure){
      if(qrCode.contains('http://www.tlddollar.com')){
        if (qrCode.contains('walletAddress')){
          Uri uri = Uri.parse(qrCode);
          String walletAddress = uri.queryParameters['walletAddress'];
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

    void transferAmount(TLDTranferAmountPramaterModel pramaterModel,Function success,Function(TLDError) failure){
      Map pramaterMap = {'chargeValue':pramaterModel.chargeValue,'chargeWalletAddress':pramaterModel.chargeWalletAddress,'fromWalletAddress ':pramaterModel.fromWalletAddress,'toWalletAddress':pramaterModel.toWalletAddress,'value':pramaterModel.value,'sign':'221321321412'};
      TLDBaseRequest request = TLDBaseRequest(pramaterMap,'wallet/transfer');
      request.postNetRequest((dynamic value) {
        success();
      }, (error) => failure(error));
    }

}