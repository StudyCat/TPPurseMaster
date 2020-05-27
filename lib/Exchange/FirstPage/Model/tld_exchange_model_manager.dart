import '../../../Base/tld_base_request.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';

class TLDSaleFormModel{
  TLDWalletInfoModel infoModel;
  String maxBuyAmount;
  String payMethodName;
  String saleAmount;
  String tmpWalletAddress;
}

class TLDExchangeModelManager{

  void submitSaleForm(TLDSaleFormModel formModel,Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAddress':formModel.infoModel.walletAddress,'payMethodName':formModel.payMethodName,'max':formModel.maxBuyAmount,'count':formModel.saleAmount},'sell/create');
    request.postNetRequest((value) {
      Map dataMap = value;
      formModel.tmpWalletAddress = dataMap['tmpWalletAddress'];
      _submitSignSaleForm(formModel, success, failure);
    }, (error) => failure(error));
  }

  void _submitSignSaleForm(TLDSaleFormModel formModel,Function success,Function(TLDError) failure){
     TLDBaseRequest request = TLDBaseRequest({'walletAddress':formModel.infoModel.walletAddress,'tmpWalletAddress':formModel.tmpWalletAddress,'sign':'formModel.maxBuyAmount','count':formModel.saleAmount},'sell/signCreate');
     request.postNetRequest((value) {
       success();
     }, (error) => failure(error));
  }

}