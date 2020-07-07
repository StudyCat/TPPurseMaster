


import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_choose_mission_level_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDPublishMissionFormModel{
  TLDPaymentModel paymentModel;
  TLDMissionLevelModel levelModel;
  String totalCount;
  String walletAddress;
}


class TLDPublishMissionModelManager{
    void getWalletInfo(String walletAddress,Function(TLDWalletInfoModel) success,Function(TLDError) failure){
      TLDBaseRequest request = TLDBaseRequest({'walletAddress' : walletAddress}, 'wallet/queryOneWallet');
      request.postNetRequest((value) {
        Map data = value;
        TLDWalletInfoModel model = TLDWalletInfoModel.fromJson(data);
        for (TLDWallet wallet  in TLDDataManager.instance.purseList) {
          if (model.walletAddress == wallet.address){
            model.wallet = wallet;
            break;
          }
        }
        success(model);
      }, (error) => failure(error));
    }
    

    void publishMission(TLDPublishMissionFormModel model,Function success,Function(TLDError) failure){
       TLDBaseRequest request = TLDBaseRequest({'levelId' : model.levelModel.taskLevel,'payId':model.paymentModel.payId,'totalCount':model.totalCount,'walletAddress':model.walletAddress}, 'newTask/releaseBuy');
      request.postNetRequest((value) {
        success();
      }, (error) => failure(error));
    }
}