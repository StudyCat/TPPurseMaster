import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDAcceptanceRankModel {
  String acptUserName;
  int rankId;
  String profitQuota;

  TLDAcceptanceRankModel(
      {this.acptUserName,
      this.rankId,
      this.profitQuota,});

  TLDAcceptanceRankModel.fromJson(Map<String, dynamic> json) {
    acptUserName = json['acptUserName'];
    rankId = json['rankId'];
    profitQuota = json['profitQuota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acptUserName'] = this.acptUserName;
    data['rankId'] = this.rankId;
    data['profitQuota'] = this.profitQuota;
    return data;
  }
}

class TLDRankAccptanceModelManager{
  void getAcceptanceRankList(Function(List) success,Function(TLDError) failure){
     TLDBaseRequest request = TLDBaseRequest({},'rank/acptSort');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        TLDAcceptanceRankModel model = TLDAcceptanceRankModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }
}