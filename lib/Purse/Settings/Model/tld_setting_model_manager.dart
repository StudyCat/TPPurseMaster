import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../Base/tld_base_request.dart';

class TLDSettingModelManager{

  void deletePurse(TLDWallet wallet,Function success ,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAdress':wallet.address,}, 'wallet/deleteWallet');
    request.postNetRequest((dynamic data)async{
      TLDDataBaseManager dataBaseManager = TLDDataBaseManager();
      await dataBaseManager.openDataBase();
      await dataBaseManager.deleteDataBase(wallet);
      await dataBaseManager.closeDataBase();
      TLDDataManager.instance.purseList.remove(wallet);
      success();
    }, (error) => failure(error));
  }

}