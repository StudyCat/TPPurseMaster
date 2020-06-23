


import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDSystemMessageModelManager{
    deleteSystemMessage(int id,Function success)async {
      TLDDataBaseManager manager = TLDDataBaseManager.instance;
      await manager.openDataBase();
      await manager.deleteSystemMessage(id);
      await manager.closeDataBase();
      success();
    }
}