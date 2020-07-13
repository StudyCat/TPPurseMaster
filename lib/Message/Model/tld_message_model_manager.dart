
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';

class TLDMessageModelManager{

  void searchChatGroup(Function(List) success)async{
    TLDNewIMManager manager = TLDNewIMManager();
    List result = await manager.getMessageConversationList();
    success(result);
  }

}