import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}     
 

class TLDBillRepayingModel {
    TLDBillRepayingModel({
this.ylbRule,
this.clearRule,
this.list,
    });


  factory TLDBillRepayingModel.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<TLDBillRepayingSonModel> list = jsonRes['list'] is List ? <TLDBillRepayingSonModel>[]: null; 
    if(list!=null) {
 for (final dynamic item in jsonRes['list']) { if (item != null) { list.add(TLDBillRepayingSonModel.fromJson(asT<Map<String,dynamic>>(item)));  } }
    }


return TLDBillRepayingModel(ylbRule : asT<String>(jsonRes['ylbRule']),
clearRule : asT<String>(jsonRes['clearRule']),
 list:list,
);}

  String ylbRule;
  String clearRule;
  List<TLDBillRepayingSonModel> list;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ylbRule': ylbRule,
        'clearRule': clearRule,
        'list': list,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class TLDBillRepayingSonModel {
    TLDBillRepayingSonModel({
this.value,
this.content,
    });


  factory TLDBillRepayingSonModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:TLDBillRepayingSonModel(value : asT<String>(jsonRes['value']),
content : asT<String>(jsonRes['content']),
);

  String value;
  String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'content': content,
};

  @override
String  toString() {
    return json.encode(this);
  }
}





class TLDBillRepayingModelManager{

  void getRepayingInfo(Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({}, 'acpt/user/getBillClearDetail');
    request.postNetRequest((value) {
      success(TLDBillRepayingModel.fromJson(value));
    }, (error) => failure(error));
  }

  void clearUser(Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({}, 'acpt/user/clearBillUser');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}