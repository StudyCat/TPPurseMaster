
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDMissionLevelModel {
  int taskLevel;
  String levelIcon;
  String levelName;
  String profitRate;

  TLDMissionLevelModel(
      {this.taskLevel, this.levelIcon, this.levelName, this.profitRate});

  TLDMissionLevelModel.fromJson(Map<String, dynamic> json) {
    taskLevel = json['taskLevel'];
    levelIcon = json['levelIcon'];
    levelName = json['levelName'];
    profitRate = json['profitRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskLevel'] = this.taskLevel;
    data['levelIcon'] = this.levelIcon;
    data['levelName'] = this.levelName;
    data['profitRate'] = this.profitRate;
    return data;
  }
}

class TLDNewMissionChooseMissionLevelModelManager{
   void getMissionLevelList(Function(List) success,Function(TLDError) failure){
     TLDBaseRequest request = TLDBaseRequest({}, 'newTask/taskLevelList');
     request.postNetRequest((value) {
       List data = value;
       List result = [];
       for (Map item in data) {
         result.add(TLDMissionLevelModel.fromJson(item));
       }
       success(result);
     }, (error) => failure(error));
   }
}