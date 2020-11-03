import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDAcceptancePersonCenterProfitModel {
  TLDAcceptancePersonCenterProfitModel({
    this.data,
    this.title,
  });

  factory TLDAcceptancePersonCenterProfitModel.fromJson(
      Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<TLDAcceptancePersonCenterProfitSonModel> data =
        jsonRes['data'] is List
            ? <TLDAcceptancePersonCenterProfitSonModel>[]
            : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']) {
        if (item != null) {
          data.add(TLDAcceptancePersonCenterProfitSonModel.fromJson(
              asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return TLDAcceptancePersonCenterProfitModel(
      data: data,
      title: asT<String>(jsonRes['title']),
    );
  }

  List<TLDAcceptancePersonCenterProfitSonModel> data;
  String title;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'title': title,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAcceptancePersonCenterProfitSonModel {
  TLDAcceptancePersonCenterProfitSonModel({
    this.value,
    this.content,
  });

  factory TLDAcceptancePersonCenterProfitSonModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDAcceptancePersonCenterProfitSonModel(
              value: asT<String>(jsonRes['value']),
              content: asT<String>(jsonRes['content']),
            );

  String value;
  String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'content': content,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAcceptancePersonCenterProfitModelManager {
  void getMyProfit(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'acpt/user/selfProfitDetail');
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TLDAcceptancePersonCenterProfitModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getInviteProfit(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'acpt/user/sjProfitDetail');
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TLDAcceptancePersonCenterProfitModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }
}
