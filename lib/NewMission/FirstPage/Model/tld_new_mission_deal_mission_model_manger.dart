
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';

class TLDNewMissionDealMissionModelManager{
  
   void getMissionBuyList(String walletAddress,int page,Function(List,String) success, Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'pageNo':page,'walletAddress':walletAddress,'pageSize':10},'newTask/taskBuyList');
    request.postNetRequest((value) {
      Map data = value;
      List dataList = data['list'];
      String progressCount = data['progressCount'];
       List result = [];
      for (Map item in dataList) {
        result.add(TLDMissionBuyInfoModel.fromJson(item));
      }
      success(result,progressCount);
    }, (error) => failure(error));
  }

    void buyMission(TLDMissionBuyPramaterModel pramaterModel ,Function(String) success, Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAddress':pramaterModel.buyerWalletAddress,'taskBuyNo':pramaterModel.taskBuyNo},'newTask/buyTask');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
    }


    

}