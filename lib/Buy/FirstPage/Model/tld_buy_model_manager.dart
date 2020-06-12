
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDBuyPramaterModel{
  String buyCount;
  String buyerAddress;
  String sellNo;
}

class TLDBuyListInfoModel {
  String sellId;
  String sellNo;
  String totalCount;
  String currentCount;
  String max;
  String payMethod;
  String sellerWalletAddress;
  String createTime;
  TLDPaymentModel payMethodVO;
  bool isMine = false;

  TLDBuyListInfoModel(
      {this.sellId,
      this.sellNo,
      this.totalCount,
      this.currentCount,
      this.max,
      this.payMethod,
      this.sellerWalletAddress,
      this.createTime,
      this.isMine,
      this.payMethodVO});

  TLDBuyListInfoModel.fromJson(Map<String, dynamic> json) {
    sellId = json['sellId'];
    sellNo = json['sellNo'];
    totalCount = json['totalCount'];
    currentCount = json['currentCount'];
    max = json['max'];
    payMethod = json['payMethod'];
    sellerWalletAddress = json['sellerWalletAddress'];
    createTime = json['createTime'];
    payMethodVO = TLDPaymentModel.fromJson(json['payMethodVO']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellId'] = this.sellId;
    data['sellNo'] = this.sellNo;
    data['totalCount'] = this.totalCount;
    data['currentCount'] = this.currentCount;
    data['max'] = this.max;
    data['payMethod'] = this.payMethod;
    data['sellerWalletAddress'] = this.sellerWalletAddress;
    data['createTime'] = this.createTime;
    data['payMethodVO'] = this.payMethodVO.toJson();
    return data;
  }
}


class TLDBuyModelManager{

  void getBuyListData(String keywords,int page,Function(List) success,Function(TLDError) failure){
    Map pramaters;
    if(keywords != null){
      pramaters = {'keywords':keywords,'pageNo':page,'pageSize':10};
    }else{
      pramaters = {'pageNo':page,'pageSize':10};
    }
    TLDBaseRequest request = TLDBaseRequest(pramaters, 'sell/buyList');
    request.postNetRequest((dynamic value) {
      Map data = value;
      List dataList = data['list'];
      List resultData = [];
      for (Map item in dataList) {
        TLDBuyListInfoModel model = TLDBuyListInfoModel.fromJson(item);
        resultData.add(model);
      }
      List purseList = TLDDataManager.instance.purseList;
      for (TLDWallet wallet in purseList) {
        for (TLDBuyListInfoModel model in resultData) {
          if(wallet.address == model.sellerWalletAddress){
            model.isMine = true;
            break;
          }
        }
      }
      success(resultData);
    }, (error) => failure(error));
  }

  void buyTLDCoin(TLDBuyPramaterModel pramaterModel,Function(String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'buyCount':pramaterModel.buyCount,'buyerAddress':pramaterModel.buyerAddress,'sellNo':pramaterModel.sellNo,'sign':'sadasdasd'}, 'order/create');
    request.postNetRequest((dynamic value) {
      Map data = value;
      String orderNo = data['orderNo'];     
      success(orderNo);
     }, (error) => failure(error));
  }
}