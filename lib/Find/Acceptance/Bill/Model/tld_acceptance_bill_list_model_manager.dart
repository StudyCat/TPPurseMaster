import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDBillBuyPramaterModel{
  int count;
  int billId;
  String walletAddress;
  String walletName;
}


class TLDAcceptanceBillListModelManager {
  void getBillList(Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'acpt/bill/billList');
    request.postNetRequest((value) {
      
    }, (error) => failure(error));
  }

  void buyBill(TLDBillBuyPramaterModel pramaterModel,Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'billCount':pramaterModel.count,'billId':pramaterModel.billId,'walletAddress':pramaterModel.walletAddress},'acpt/bill/buyBill');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}