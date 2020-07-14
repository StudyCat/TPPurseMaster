// import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// //消息广播
// class TLDMessageEvent {
//    List messageList;
//    TLDMessageEvent(this.messageList);
// }

// //未读消息广播
// class TLDHaveUnreadMessageEvent{
//   bool haveUnreadMessage;
//   TLDHaveUnreadMessageEvent(this.haveUnreadMessage);
// }

// //系统消息广播
// class TLDSystemMessageEvent{
//   TLDMessageModel messageModel;
//   TLDSystemMessageEvent(this.messageModel);
// }

// 进入聊天界面广播
class TLDInIMPageEvent{
  
}

//更新消息列表广播
class TLDRefreshMessageListEvent{
  int refreshPage; // 1为普通IM页 2位系统页 3为两者
  TLDRefreshMessageListEvent(this.refreshPage);
}

//更新首页广播
class TLDRefreshFirstPageEvent{
  TLDRefreshFirstPageEvent();
}

//底部导航栏点击广播
class TLDBottomTabbarClickEvent{
  int index;
  TLDBottomTabbarClickEvent(this.index);
}

//消息推送通知