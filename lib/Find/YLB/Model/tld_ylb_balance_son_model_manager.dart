

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}     
 

class TLDYLBDetailProfitModel {
    TLDYLBDetailProfitModel({
this.totalProfit,
this.lastProfit,
this.profitRate,
this.totalCount,
this.transferCount,
    });


  factory TLDYLBDetailProfitModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:TLDYLBDetailProfitModel(totalProfit : asT<String>(jsonRes['totalProfit']),
lastProfit : asT<String>(jsonRes['lastProfit']),
profitRate : asT<String>(jsonRes['profitRate']),
totalCount : asT<String>(jsonRes['totalCount']),
transferCount : asT<String>(jsonRes['transferCount']),
);

  String totalProfit;
  String lastProfit;
  String profitRate;
  String totalCount;
  String transferCount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'totalProfit': totalProfit,
        'lastProfit': lastProfit,
        'profitRate': profitRate,
        'totalCount': totalCount,
        'transferCount': transferCount,
};

  @override
String  toString() {
    return json.encode(this);
  }
}



class TLDYLBBalanceSonModelManager{
  void getDetailProfitInfo(int type,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'type' : type},'ylb/ylbAccountDetail');
    request.postNetRequest((value) {
      success(TLDYLBDetailProfitModel.fromJson(value));
    }, (error) => failure(error));
  }

  void rollIn(int type,String walletAddress,String amount,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'type':type,'walletAddress':walletAddress,'tldCount' : amount},'ylb/ylbTransferIn');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void rollOut(int type,String walletAddress,String amount,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'type':type,'walletAddress':walletAddress,'tldCount' : amount},'ylb/ylbTransferOut');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}