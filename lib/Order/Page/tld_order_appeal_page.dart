import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../CommonWidget/tld_clip_common_cell.dart';
import '../View/tld_detail_order_paymethod_cell.dart';
import '../../Drawer/UserFeedback/View/tld_user_feedback_question_desc_cell.dart';
import '../../Drawer/UserFeedback/View/tld_user_feedback_pick_pic_cell.dart';
import 'package:image_picker/image_picker.dart';
import '../../CommonWidget/tld_image_show_page.dart';

class TLDOrderAppealPage extends StatefulWidget {
  TLDOrderAppealPage({Key key}) : super(key: key);

  @override
  _TLDOrderAppealPageState createState() => _TLDOrderAppealPageState();
}

class _TLDOrderAppealPageState extends State<TLDOrderAppealPage> {
  List titles = ['订单号', '卖家收款方式', '卖家地址', '买家地址', '描述（200字以内）', '截图上传'];

  bool isOpen;

  List images = [];

  PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isOpen = false;

    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'order_appeal_page',
        transitionBetweenRoutes: false,
        middle: Text('订单申诉'),
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
          if (index == 1) {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDDetailOrderPayMethodCell(
                title: titles[index],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
                isOpen: isOpen,
                isBank: true,
                didClickCallBack: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
              ),
            );
          } else if (index == 4) {
            return _getPadding(TLDUserFeedbackQuestionDescCell(
              title: titles[index],
              placeholder: '请描述您的申诉问题',
            ));
          } else if (index == 5) {
            return _getPadding(TLDUserFeedbackPickPicCell(
                title: titles[index],
                subTitle: '（单个图片2M以内，最多三张图片）',
                images: images,
                didClickCallBack: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          actions: <Widget>[
                            CupertinoButton(
                                child: Text('拍摄'),
                                onPressed: () {
                                  _takePhoto();
                                  Navigator.of(context).pop();
                                }),
                            CupertinoButton(
                                child: Text('从相册选择'),
                                onPressed: () {
                                  _openGallery();
                                  Navigator.of(context).pop();
                                }),
                          ],
                          cancelButton: CupertinoButton(
                              child: Text('取消'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        );
                      });
                },
                didClickImageCallBack: (int index) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TLDImageShowPage(
                                images: images,
                                pageController: _controller,
                                index: index,
                                heroTag: 'user_feedback',
                                isShowDelete: true,
                                deleteCallBack: (int index) {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                              )));
                }));
          }

          return _getNormalCell(context, ScreenUtil().setHeight(2), index);
        });
  }

  Widget _getNormalCell(BuildContext context, num top, int index) {
    return Padding(
      padding: EdgeInsets.only(
          top: top,
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normal,
          title: titles[index],
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: 'fwefwefwe',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 153, 153, 153)),
        ),
      ),
    );
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
  void _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
  }
}
