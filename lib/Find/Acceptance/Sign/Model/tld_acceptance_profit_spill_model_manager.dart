


import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDAcceptanceProfitSpillListModel {
  int billId;
  int billLevel;
  String billIcon;
  String overflowCount;
  String acptOrderNo;

  TLDAcceptanceProfitSpillListModel(
      {this.billId, this.billLevel, this.billIcon, this.overflowCount});

  TLDAcceptanceProfitSpillListModel.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    billLevel = json['billLevel'];
    billIcon = json['billIcon'];
    overflowCount = json['overflowCount'];
    acptOrderNo = json['acptOrderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['billLevel'] = this.billLevel;
    data['billIcon'] = this.billIcon;
    data['overflowCount'] = this.overflowCount;
    data['acptOrderNo'] = this.acptOrderNo;
    return data;
  }
}

class TLDAcceptanceProfitSpillModelManager {
  void getSpillList(Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'acpt/user/overflowProfit');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        result.add(TLDAcceptanceProfitSpillListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getProfit(String acptOrderNo,Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'acptOrderNo':acptOrderNo},'acpt/user/acptOrderNo');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}