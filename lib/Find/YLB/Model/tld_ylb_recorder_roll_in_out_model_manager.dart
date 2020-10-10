

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_profit_model_manager.dart';



class TLDYLBRecorderRollInOutModelManager{

  void getRollInList(int page,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'pageSize' : '10','pageNo':page},'ylb/transferInLog');
    request.postNetRequest((value) {
            List result = [];
      List profitList = value['list'];
      for (Map item in profitList) {
        result.add(TLDYLBProfitListModel.fromJson(item));
      }
      success(result);
    }, (TLDError error) => failure(error));
  }


  void getRollOutList(int page,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'pageSize' : '10','pageNo':page},'ylb/transferOutLog');
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