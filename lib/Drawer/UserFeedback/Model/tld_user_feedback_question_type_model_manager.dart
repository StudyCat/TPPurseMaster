
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDUserFeedbackQuestionTypeModel {
  String typeName;
  int questionTypeId;

  TLDUserFeedbackQuestionTypeModel({this.typeName, this.questionTypeId});

  TLDUserFeedbackQuestionTypeModel.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    questionTypeId = json['questionTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeName'] = this.typeName;
    data['questionTypeId'] = this.questionTypeId;
    return data;
  }
}

class TLDUserFeedbackQuestionTypeModelManager{
  void getQuestTypeList(Function(List) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'question/typeList');
    request.postNetRequest((dynamic value) {
        Map data = value;
        List dataList = data['list'];
        List resultList = [];
        for (Map item in dataList) {
          TLDUserFeedbackQuestionTypeModel model = TLDUserFeedbackQuestionTypeModel.fromJson(item);
          resultList.add(model);
        }
        success(resultList);
    }, (error) => failure(error));
  }
}