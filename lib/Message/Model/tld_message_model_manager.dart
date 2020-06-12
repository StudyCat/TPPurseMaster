import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';

import '../../dataBase/tld_database_manager.dart';
class TLDMessageModelManager{

  void searchChatGroup(Function(List) success)async{
     TLDDataBaseManager _manager = TLDDataBaseManager();
     await _manager.openDataBase();
     List fromList = await _manager.searchFromAddressChatGroup();
     List toList = await _manager.searchToAddressChatGroup();
    await _manager.closeDataBase();
    List groupList = [];
    List deleteList = [];
    for (TLDMessageModel fromMessageModel in fromList) {
        for (TLDMessageModel toMessageModel in toList) {
          if (fromMessageModel.fromAddress == toMessageModel.toAddress){
            if (fromMessageModel.createTime > toMessageModel.createTime){
              groupList.add(fromMessageModel);
            }else{
              groupList.add(toMessageModel);
            }
            deleteList.add(fromMessageModel);
            deleteList.add(toMessageModel);
          }
        }
    }
    success(groupList);
  }

}