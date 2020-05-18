import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List images = [];

  List icons = [0xe679, 0xe61d, 0xe630];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
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
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          if (index < 3) {
            return _getPadding(TLDClipTitleInputCell(
              placeholder: placeholders[index],
              title: titles[index],
              titleFontSize: ScreenUtil().setSp(28),
            ));
          } else if (index == 3){
            return _getPadding(_getQuestionTypeCell(titles[index],placeholders[index]));
          }else if(index == 4){
            return _getPadding(TLDUserFeedbackQuestionDescCell(title: titles[index],placeholder: placeholders[index],));
          }else{
            return _getPadding(TLDUserFeedbackPickPicCell(title: titles[index],images: images,didClickCallBack: (){
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDImageShowPage(images: images,pageController: _pageController,index: index,heroTag: 'user_feedback',isShowDelete: true,deleteCallBack: (int index){
                setState(() {
                  images.removeAt(index);
                });
              },)));
            },
            ));
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
      images.add(image);
    });
    }
  }

  /*相册*/
void  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery); 
    if (image != null) {
     setState(() {
      images.add(image);
    }); 
    }
  }

}
