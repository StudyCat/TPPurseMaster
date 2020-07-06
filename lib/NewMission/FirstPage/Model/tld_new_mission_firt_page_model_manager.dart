

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDNewMissionFirstPageModelManager{
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

}