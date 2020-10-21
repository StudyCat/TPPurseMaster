import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDSignMineModel {
  TLDSignMineModel({
    this.signProfitCount,
    this.signDesc,
    this.createTime,
  });

  factory TLDSignMineModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDSignMineModel(
              signProfitCount: asT<String>(jsonRes['signProfitCount']),
              signDesc: asT<String>(jsonRes['signDesc']),
              createTime: asT<int>(jsonRes['createTime']),
            );

  String signProfitCount;
  String signDesc;
  int createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'signProfitCount': signProfitCount,
        'signDesc': signDesc,
        'createTime': createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDSignListMineModelManager {
  void getSignList(int page,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'pageNo':page,'pageSize':10},'acpt/user/mySignList');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        TLDSignMineModel model = TLDSignMineModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }
}
