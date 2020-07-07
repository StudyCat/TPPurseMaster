import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';

import '../../dataBase/tld_database_manager.dart';
class TLDMessageModelManager{

  void searchChatGroup(Function(List) success)async{
     TLDDataBaseManager _manager = TLDDataBaseManager();
     await _manager.openDataBase();
    //  List fromList = await _manager.searchFromAddressChatGroup();
    //  List toList = await _manager.searchToAddressChatGroup();
    List result = await _manager.searchOrderNoChatGroup();
    await _manager.closeDataBase();

    for (TLDMessageModel item in result) {
      int unreadCount = 0;
      for (TLDMessageModel  unreadMessage in TLDIMManager.instance.unreadMessage) {
        if (unreadMessage.orderNo == item.orderNo){
          unreadCount = unreadCount + 1;
        }
      }
      item.unreadCount = unreadCount;
    }

    success(result);
  }

}