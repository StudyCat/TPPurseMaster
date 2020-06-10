import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//消息广播
class TLDMessageEvent {
   List messageList;
   TLDMessageEvent(this.messageList);
}

//未读消息广播
class TLDHaveUnreadMessageEvent{
  bool haveUnreadMessage;
  TLDHaveUnreadMessageEvent(this.haveUnreadMessage);
}