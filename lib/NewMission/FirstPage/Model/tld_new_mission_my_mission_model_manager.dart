

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';

class TLDNewMissionMyMissionModelManager{
  void getMyMissionList(String walletAddress,int page,Function(List) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAddress':walletAddress,'pageNo':page,'pageSize':10},'newTask/myTaskList');
    request.postNetRequest((value) {
         Map data = value;
      List dataList = data['list'];
       List result = [];
      for (Map item in dataList) {
        result.add(TLDOrderListModel.fromJson(item));
      }
      success(result);
    }, (TLDError error){
      failure(error);
    });
  }
}