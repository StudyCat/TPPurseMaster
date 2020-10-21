import 'dart:convert' show json;
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDTeamStarModel {
  TLDTeamStarModel({
    this.curProfit,
    this.teamLevel,
    this.addProfit,
    this.starLevel,
    this.levelIcon,
  });

  factory TLDTeamStarModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDTeamStarModel(
              curProfit: asT<String>(jsonRes['curProfit']),
              teamLevel: asT<int>(jsonRes['teamLevel']),
              addProfit: asT<String>(jsonRes['addProfit']),
              starLevel: asT<int>(jsonRes['starLevel']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
            );

  String curProfit;
  int teamLevel;
  String addProfit;
  int starLevel;
  String levelIcon;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'curProfit': curProfit,
        'teamLevel': teamLevel,
        'addProfit': addProfit,
        'starLevel': starLevel,
        'levelIcon': levelIcon,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAAAPlusStarModelManager {
  void getStarList(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'aaa/upgradeStarDetail');
    request.postNetRequest((value) {
      List starList = value['list'];
      List result = [];
      for (Map item in starList) {
        result.add(TLDTeamStarModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }
}
