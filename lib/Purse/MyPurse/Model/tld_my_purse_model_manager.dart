import 'package:dragon_sword_purse/Base/tld_base_request.dart';


class TLDPurseTransferInfoModel {
  int createTime;
  int txId;
  String fromWalletAddress;
  String toWalletAddress;
  String chargeValue;
  String value;

  TLDPurseTransferInfoModel(
      {this.createTime,
      this.txId,
      this.fromWalletAddress,
      this.toWalletAddress,
      this.chargeValue,
      this.value});

  TLDPurseTransferInfoModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    txId = json['txId'];
    fromWalletAddress = json['fromWalletAddress'];
    toWalletAddress = json['toWalletAddress'];
    chargeValue = json['chargeValue'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['txId'] = this.txId;
    data['fromWalletAddress'] = this.fromWalletAddress;
    data['toWalletAddress'] = this.toWalletAddress;
    data['chargeValue'] = this.chargeValue;
    data['value'] = this.value;
    return data;
  }
}



class TLDMyPurseModelManager{
  void getPurseTransferList(int page,int type,String walletAddress ,Function(List) success,Function(TLDError) failure){
    Map paramater = {'pageNo':page,'pageSize': 10,'type' : type,'walletAddress':walletAddress};
    TLDBaseRequest request = TLDBaseRequest(paramater,'wallet/transferList');
    request.postNetRequest((dynamic value) {
      Map data = value;
      List dataList = data['list'];
      List result = [];
      for (Map item in dataList) {
        TLDPurseTransferInfoModel model = TLDPurseTransferInfoModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (TLDError error){
      failure(error);
    });
  }
}