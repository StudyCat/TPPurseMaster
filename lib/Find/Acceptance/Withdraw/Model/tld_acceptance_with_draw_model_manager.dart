
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TLDAceeptanceWithdrawUsefulInfoModel {
  String acptPlatformCachRate;
  String walletAddress;
  String value;
  String inviteTel;
  bool showPlatform;

  TLDAceeptanceWithdrawUsefulInfoModel(
      {this.acptPlatformCachRate, this.walletAddress, this.value,this.inviteTel});

  TLDAceeptanceWithdrawUsefulInfoModel.fromJson(Map<String, dynamic> json) {
    acptPlatformCachRate = json['acptPlatformCachRate'];
    walletAddress = json['walletAddress'];
    value = json['value'];
    inviteTel = json['inviteTel'];
    showPlatform = json['showPlatform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acptPlatformCachRate'] = this.acptPlatformCachRate;
    data['walletAddress'] = this.walletAddress;
    data['value'] = this.value;
    data['inviteTel'] = this.inviteTel;
    data['showPlatform'] = this.showPlatform;
    return data;
  }
}

class TLDWithdrawPramaterModel {
  int cashType;
  String cashCount;
  TLDPaymentModel paymentModel;
  String walletAddress;
}

class TLDAcceptanceWithdrawModelManager {
  
  void getUsefulInfo(Function(TLDAceeptanceWithdrawUsefulInfoModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'acpt/cash/getCachCharge');
    request.postNetRequest((value) {
      success(TLDAceeptanceWithdrawUsefulInfoModel.fromJson(value));
    }, (error) => failure(error));
  }

  void withdraw(TLDWithdrawPramaterModel pramaterModel,Function(String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'cashCount':pramaterModel.cashCount,'cashType':pramaterModel.cashType,'payId':pramaterModel.paymentModel.payId,'walletAddress' : pramaterModel.walletAddress},'acpt/cash/newCash');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

}