import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Model/tld_user_feedback_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Model/tld_user_feedback_question_type_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Page/tld_user_feedback_question_type_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import '../View/tld_user_feedback_question_desc_cell.dart';
import '../View/tld_user_feedback_pick_pic_cell.dart';
import 'package:image_picker/image_picker.dart';
import '../../../CommonWidget/tld_image_show_page.dart';

class TLDUserFeedBackPage extends StatefulWidget {
  TLDUserFeedBackPage({Key key}) : super(key: key);

  @override
  _TLDUserFeedBackPageState createState() => _TLDUserFeedBackPageState();
}

class _TLDUserFeedBackPageState extends State<TLDUserFeedBackPage> {
  List titles = [
    '称呼',
    '手机号码',
    '邮箱',
    '问题类型',
    '问题具体描述',
    '截图上传',
  ];

  List placeholders = [
    '请输入您的称呼',
    '请输入您的手机号',
    '请输入您的邮箱号码',
    '请选择问题类型',
    '请描述您的具体问题'
  ];

  PageController _pageController;

  List icons = [0xe679, 0xe61d, 0xe630];

  TLDUserFeedBackPramatersModel _pramatersModel;

  TLDUserFeedBackModelManager _manager;

  bool _loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();

    _manager = TLDUserFeedBackModelManager();

    _pramatersModel = TLDUserFeedBackPramatersModel();

    _loading = false;
  }

  void _sendUserFeedBackQuestion(){
    if (_pramatersModel.nickname.length == 0){
      Fluttertoast.showToast(msg: '请填写您的称呼，便于我们联系您',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.tel.length == 0){
      Fluttertoast.showToast(msg: '请填写您的手机号，便于我们联系您',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.email.length == 0){
      Fluttertoast.showToast(msg: '请填写您的电子邮箱地址，便于我们联系您',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.questionType == null){
      Fluttertoast.showToast(msg: '请选择问题类型',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.questionDesc.length == 0){
      Fluttertoast.showToast(msg: '请填写问题描述',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.sendFeedBack(_pramatersModel, (){
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(msg: '反馈成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TLDError error){
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'user_feedback_page',
        transitionBetweenRoutes: false,
        middle: Text('用户反馈'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          if (index < 3) {
            return _getPadding(TLDClipTitleInputCell(
              placeholder: placeholders[index],
              title: titles[index],
              titleFontSize: ScreenUtil().setSp(28),
              textFieldEditingCallBack: (String text){
                if (index == 0){
                  _pramatersModel.nickname = text;
                }else if(index == 1){
                  _pramatersModel.tel = text;
                }else if (index == 2){
                  _pramatersModel.email = text;
                }
              },
            ));
          } else if (index == 3){
            String content = _pramatersModel.questionType == null ? '请选择问题类型' : _pramatersModel.questionType.typeName;
            return GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => TLDUserFeedbackQuestionTypePage(didChooseQuestionTypeCallBack: (TLDUserFeedbackQuestionTypeModel questionTypeModel){
                setState(() {
                  _pramatersModel.questionType = questionTypeModel;
                });
              },))),
              child: _getPadding(_getQuestionTypeCell(titles[index],content)),
              );
          }else if(index == 4){
            return _getPadding(TLDUserFeedbackQuestionDescCell(title: titles[index],placeholder: placeholders[index],stringDidChangeCallBack: (String text){
              _pramatersModel.questionDesc = text;
            },));
          }else if (index == 5){
            return _getPadding(TLDUserFeedbackPickPicCell(title: titles[index],images: _pramatersModel.imageFileList,didClickCallBack: (){
              showCupertinoModalPopup(context: context,builder : (BuildContext context){
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoButton(child: Text('拍摄'), onPressed: (){
                          _takePhoto();
                          Navigator.of(context).pop();
                        }),
                        CupertinoButton(child: Text('从相册选择'), onPressed: (){
                          _openGallery();
                          Navigator.of(context).pop();
                        }),
                      ],
                      cancelButton: CupertinoButton(child: Text('取消'), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    );
                  });
            },
            didClickImageCallBack: (int index){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDImageShowPage(images: _pramatersModel.imageFileList,pageController: _pageController,index: index,heroTag: 'user_feedback',isShowDelete: true,deleteCallBack: (int index){
                setState(() {
                  _pramatersModel.imageFileList.removeAt(index);
                });
              },)));
            },
            ));
          }else {
            return Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(40),
                  left: ScreenUtil().setWidth(100),
                  right: ScreenUtil().setWidth(100)),
              height: ScreenUtil().setHeight(80),
              width: size.width - ScreenUtil().setWidth(200),
              child: CupertinoButton(
                  child: Text(
                    '提交反馈',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28), color: Colors.white),
                  ),
                  padding: EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _sendUserFeedBackQuestion();
                  }),
            );
          }
        });
  }

  Widget _getPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(2)),
      child: child,
    );
  }

  Widget _getQuestionTypeCell(String title, String content) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(content,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromARGB(255, 153, 153, 153))),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              )
            ]),
      ),
    );
  }

   /*拍照*/
  void _takePhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted || status == PermissionStatus.undetermined) {
      Fluttertoast.showToast(msg: '请先开启相机权限',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
      _pramatersModel.imageFileList.add(image);
    });
    }
  }

  /*相册*/
void  _openGallery() async {
  var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
      Fluttertoast.showToast(msg: '请先开启相册权限',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery); 
    if (image != null) {
     setState(() {
      _pramatersModel.imageFileList.add(image);
    }); 
    }
  }

}
