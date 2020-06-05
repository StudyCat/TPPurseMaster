
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Model/tld_user_feedback_question_type_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TLDUserFeedbackQuestionTypePage extends StatefulWidget {
  TLDUserFeedbackQuestionTypePage({Key key,this.didChooseQuestionTypeCallBack}) : super(key: key);

  final Function(TLDUserFeedbackQuestionTypeModel) didChooseQuestionTypeCallBack;

  @override
  _TLDUserFeedbackQuestionTypePageState createState() => _TLDUserFeedbackQuestionTypePageState();
}

class _TLDUserFeedbackQuestionTypePageState extends State<TLDUserFeedbackQuestionTypePage> {

  List _dataSource;

  TLDUserFeedbackQuestionTypeModelManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dataSource = [];

    _manager = TLDUserFeedbackQuestionTypeModelManager();

    _getQuestionTypeList();
  }

  void _getQuestionTypeList(){
    _manager.getQuestTypeList((List resultList){
      setState(() {
        _dataSource.addAll(resultList);
      });
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_question_type_page',
        transitionBetweenRoutes: false,
        middle: Text('选择问题类型'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        TLDUserFeedbackQuestionTypeModel model = _dataSource[index];
        return GestureDetector(
          onTap: (){
           widget.didChooseQuestionTypeCallBack(model);
           Navigator.of(context).pop(); 
          },
          child: Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(2)),
            child: TLDClipCommonCell(title: model.typeName,titleStyle: TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28)),type: TLDClipCommonCellType.normalArrow,content: '',),
          )
        );
     });
  }
}