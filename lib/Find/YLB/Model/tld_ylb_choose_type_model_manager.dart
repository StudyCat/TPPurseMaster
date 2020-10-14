import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDYLBTypeModel {
  TLDYLBTypeModel({
    this.balance,
    this.typeName,
    this.type,
  });

  factory TLDYLBTypeModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDYLBTypeModel(
              balance: asT<String>(jsonRes['balance']),
              typeName: asT<String>(jsonRes['typeName']),
              type: asT<int>(jsonRes['type']),
            );

  String balance;
  String typeName;
  int type;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'balance': balance,
        'typeName': typeName,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDYLBChooseTypeModelManager {
  void getTypeList(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'ylb/accountBalance');
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TLDYLBTypeModel.fromJson(item));
      }
      success(result);
    }, (TLDError error) => failure(error));
  }
}
