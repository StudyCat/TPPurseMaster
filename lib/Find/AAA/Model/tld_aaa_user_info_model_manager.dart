

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';

class TLDAAAUserInfoModelManager{

  void getUserInfo(int userId,Function success,Function failure){
        TLDBaseRequest request = TLDBaseRequest({'aaaUserId':userId}, 'aaa/accountUserDetail');
    request.postNetRequest((value) {
      Map valueMap = value;
      if (valueMap.length == 0){
        success(TLDAAAUserInfo());
      }else{
        success(TLDAAAUserInfo.fromJson(valueMap));
      }
    }, (error) => failure(error));
  }

}