

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDGetTaskPramaterModel{
  String walletAddress;
  String taskNo;
}


class TLDMissionFirstModelManager{

  void getMission(TLDGetTaskPramaterModel pramaterModel,Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'taskNo':pramaterModel.taskNo,'walletAddress':pramaterModel.walletAddress}, 'task/receiveTask');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}