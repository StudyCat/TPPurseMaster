import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';


class TLDPurseTransferInfoModel {
  int createTime;
  int txId;
  String fromWalletAddress;
  String toWalletAddress;
  String chargeValue;
  String value;
  String remark;

  TLDPurseTransferInfoModel(
      {this.createTime,
      this.txId,
      this.fromWalletAddress,
      this.toWalletAddress,
      this.chargeValue,
      this.value,
      this.remark});

  TLDPurseTransferInfoModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    txId = json['txId'];
    fromWalletAddress = json['fromWalletAddress'];
    toWalletAddress = json['toWalletAddress'];
    chargeValue = json['chargeValue'];
    value = json['value'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['txId'] = this.txId;
    data['fromWalletAddress'] = this.fromWalletAddress;
    data['toWalletAddress'] = this.toWalletAddress;
    data['chargeValue'] = this.chargeValue;
    data['value'] = this.value;
    data['remark'] = this.remark;
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

  void getWalletData(TLDWallet wallet,Function(TLDWalletInfoModel) success,Function(TLDError) failure)async {
      List addressList = [];
      addressList.add(wallet.address);
      String addressListJson = jsonEncode(addressList);
      TLDBaseRequest request = TLDBaseRequest({"list":addressListJson}, 'wallet/queryWallet');
     request.postNetRequest((dynamic data) {
      Map dataMap = data;
      List dataList = dataMap['list'];
      List<TLDWalletInfoModel> result = [];
      for (Map infoMap in dataList) {
        if (infoMap['walletAddress'] == wallet.address){
          TLDWalletInfoModel model = TLDWalletInfoModel.fromJson(infoMap);
          model.wallet = wallet;            
          result.add(model);
          break;
        }
      }
      success(result.first);
       }, (error)=> failure(error));
  }
}