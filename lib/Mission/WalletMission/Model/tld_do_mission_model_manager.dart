

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TLDMissionBuyInfoModel {
  int taskBuyId;
  String taskBuyNo;
  String tmpWalletAddress;
  int taskLevel;
  String levelIcon;
  int payId;
  TLDPaymentModel payMethodVO;
  String quote;
  String receiveWalletAddress;
  String totalCount;
  String currentCount;
  int createTime;

  TLDMissionBuyInfoModel(
      {this.taskBuyId,
      this.taskBuyNo,
      this.tmpWalletAddress,
      this.taskLevel,
      this.levelIcon,
      this.payId,
      this.payMethodVO,
      this.quote,
      this.totalCount,
      this.currentCount,
      this.createTime,
      this.receiveWalletAddress});

  TLDMissionBuyInfoModel.fromJson(Map<String, dynamic> json) {
    taskBuyId = json['taskBuyId'];
    taskBuyNo = json['taskBuyNo'];
    tmpWalletAddress = json['tmpWalletAddress'];
    taskLevel = json['taskLevel'];
    levelIcon = json['levelIcon'];
    payId = json['payId'];
    payMethodVO = json['payMethodVO'] != null
        ? new TLDPaymentModel.fromJson(json['payMethodVO'])
        : null;
    quote = json['quote'];
    totalCount = json['totalCount'];
    currentCount = json['currentCount'];
    createTime = json['createTime'];
    receiveWalletAddress = json['receiveWalletAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskBuyId'] = this.taskBuyId;
    data['taskBuyNo'] = this.taskBuyNo;
    data['tmpWalletAddress'] = this.tmpWalletAddress;
    data['taskLevel'] = this.taskLevel;
    data['levelIcon'] = this.levelIcon;
    data['payId'] = this.payId;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['quote'] = this.quote;
    data['totalCount'] = this.totalCount;
    data['currentCount'] = this.currentCount;
    data['createTime'] = this.createTime;
    data['receiveWalletAddress'] = this.receiveWalletAddress;
    return data;
  }
}


class TLDMissionBuyPramaterModel{
  int taskWalletId;
  String quote;
  String buyerWalletAddress;
  String taskBuyNo;
}

class TLDDoMissionModelManager{

  void getMissionBuyList(int page,int taskWalletId,Function(List) success, Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'pageNo':page,'taskWalletId':taskWalletId,'pageSize':10},'task/taskBuyList');
    request.postNetRequest((value) {
      Map data = value;
      List dataList = data['list'];
       List result = [];
      for (Map item in dataList) {
        result.add(TLDMissionBuyInfoModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void buyMission(TLDMissionBuyPramaterModel pramaterModel ,Function(String) success, Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'quote':pramaterModel.quote,'taskWalletId':pramaterModel.taskWalletId,'taskBuyNo':pramaterModel.taskBuyNo},'task/buyTaskOrder');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

}