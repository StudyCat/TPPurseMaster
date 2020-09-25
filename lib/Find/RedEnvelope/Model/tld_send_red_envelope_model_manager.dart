

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDSendRedEnvelopePramater{
  String desc;
  int policy;//红包策略
  int redEnvelopeNum;
  String tldCount;
  String walletAddress;
  int type;
}

class TLDSendRedEnvelopeModelManager{
  void sendRedEnvelope(TLDSendRedEnvelopePramater pramater,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'desc':pramater.desc,'policy':pramater.policy,'redEnvelopeNum':pramater.redEnvelopeNum,'tldCount':pramater.tldCount,'walletAddress':pramater.walletAddress,'type':pramater.type}, 'redEnvelope/generateRedEnvelope');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}