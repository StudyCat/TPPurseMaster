import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDYLBProfitListModel {
  TLDYLBProfitListModel({
    this.logId,
    this.tldCount,
    this.type,
    this.typeName,
    this.createTime,
  });

  factory TLDYLBProfitListModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDYLBProfitListModel(
              logId: asT<int>(jsonRes['logId']),
              tldCount: asT<String>(jsonRes['tldCount']),
              type: asT<int>(jsonRes['type']),
              typeName: asT<String>(jsonRes['typeName']),
              createTime: asT<int>(jsonRes['createTime']),
            );

  int logId;
  String tldCount;
  int type;
  String typeName;
  int createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'logId': logId,
        'tldCount': tldCount,
        'type': type,
        'typeName': typeName,
        'createTime': createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDYLBRecorderProfitModelManager {
  void getProfitList(int page, Function success, Function failure) {
    TLDBaseRequest request =
        TLDBaseRequest({'pageSize': '10', 'pageNo': page}, 'ylb/ylbProfitLog');
    request.postNetRequest((value) {
      List result = [];
      List profitList = value['list'];
      for (Map item in profitList) {
        result.add(TLDYLBProfitListModel.fromJson(item));
      }
      success(result);
    }, (TLDError error) => failure(error));
  }
}
