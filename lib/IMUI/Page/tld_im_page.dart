import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/IMUI/Model/tld_im_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_im_input_view.dart';
import '../View/tld_im_header_view.dart';
import '../View/tld_im_other_user_word_message_cell.dart';
import '../View/tld_im_user_word_message_cell.dart';
import '../View/tld_im_user_time_word_message_cell.dart';
import '../View/tld_im_other_user_time_word_message_cell.dart';
import '../View/tld_im_other_user_image_message_cell.dart';
import '../View/tld_im_user_image_message_cell.dart';
import '../View/tld_im_other_user_time_image_message_cell.dart';
import '../View/tld_im_user_time_image_message_cell.dart';

class TLDIMPage extends StatefulWidget {
  TLDIMPage({Key key, this.selfWalletAddress, this.otherGuyWalletAddress,this.orderNo})
      : super(key: key);

  final String selfWalletAddress;

  final String otherGuyWalletAddress;

  final String orderNo;

  @override
  _TLDIMPageState createState() => _TLDIMPageState();
}

class _TLDIMPageState extends State<TLDIMPage> {
  List _dataSource = [];

  int _page;

  TLDIMManager _manager;

  ScrollController _controller;

  TLDIMModelManager _modelManager;

  RefreshController _refreshController;

  StreamSubscription _messageSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _page = 0;

    _controller = ScrollController();

    _modelManager = TLDIMModelManager();

    _manager = TLDIMManager.instance;
    _manager.isOnChatPage = true;
    _manager.talkAddress = widget.otherGuyWalletAddress;

    _refreshController = RefreshController(initialRefresh: false);
    
    getMessageList(_page);

    registerEvent();
  }

  void getMessageList(int page) {
    _manager.getMsssageList(widget.orderNo, page,
        (List messages) {
      if (page == 0) {
        setState(() {
          _dataSource.addAll(messages);
        });
        Timer(Duration(milliseconds: 500),
            () => _controller.jumpTo(_controller.position.maxScrollExtent));
      } else {
        setState(() {
          _dataSource.insertAll(0, messages);
        });
      }
      if (messages.length > 0) {
        _page = page + 1;
      }
      _refreshController.refreshCompleted();
    });
  }
  //注册广播
  void registerEvent(){
    _messageSubscription = eventBus.on<TLDMessageEvent>().listen((event) {
      setState(() {
            _dataSource.addAll(event.messageList);
          });
          Timer(Duration(milliseconds: 500),
              () => _controller.jumpTo(_controller.position.maxScrollExtent));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _messageSubscription.cancel();
    _manager.isOnChatPage = false;
    _manager.talkAddress = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'im_page',
        transitionBetweenRoutes: false,
        middle: Text('联系卖家'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBody(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  /*拍照*/
  void _takePhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
      Fluttertoast.showToast(msg: '请先开启相机权限',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      sendImageMessage(image);
    }
  }

  /*相册*/
  void _openGallery() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
      Fluttertoast.showToast(msg: '请先开启相册权限',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        sendImageMessage(image);
      });
    }
  }

  void sendImageMessage(File image) {
    _modelManager.uploadImageInservice(image, (String url) {
      TLDMessageModel messageModel = TLDMessageModel();
      messageModel.content = url;
      messageModel.fromAddress = widget.selfWalletAddress;
      messageModel.toAddress = widget.otherGuyWalletAddress;
      messageModel.contentType = 2;
      messageModel.createTime = DateTime.now().millisecondsSinceEpoch;
      messageModel.messageType = 2;
      messageModel.orderNo = widget.orderNo;
      TLDIMManager manager = TLDIMManager.instance;
      manager.sendMessage(messageModel);
    }, (TLDError error) {
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

  Widget _getFreshWidget(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(complete: Container()),
      onRefresh: () => getMessageList(_page),
      child: _getMessageListView(context),
    );
  }

  Widget _getMessageListView(BuildContext context) {
    return ListView.builder(
      itemCount: _dataSource.length,
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        TLDMessageModel model = _dataSource[index];
        if (model.contentType == 1) {
          if (_isNeedToshowTimeLabel(index)) {
            if (widget.otherGuyWalletAddress == model.toAddress) {
              return TLDIMUserTimeWordMessageCell(
                content: model.content,
                createTime: model.createTime,
              );
            } else {
              return TLDIMOtherUserTimeWordMessageCell(
                content: model.content,
                createTime: model.createTime,
              );
            }
          } else {
            if (widget.otherGuyWalletAddress == model.toAddress) {
              return TLDIMUserWordMessageCell(
                content: model.content,
              );
            } else {
              return TLDIMOtherUserWordMessageCell(
                content: model.content,
              );
            }
          }
        } else {
          if (_isNeedToshowTimeLabel(index)) {
            if (widget.otherGuyWalletAddress == model.toAddress) {
              return TLDIMUserTimeImageMessageCell(
                imageUrl: model.content,
                createTime: model.createTime,
              );
            } else {
              return TLDIMOtherUserTimeImageMessageCell(
                imageUrl: model.content,
                createTime: model.createTime,
              );
            }
          } else {
            if (widget.otherGuyWalletAddress == model.toAddress) {
              return TLDIMUserImageMessageCell(
                imageUrl: model.content,
              );
            } else {
              return TLDIMOtherUserImageMessageCell(
                imageUrl: model.content,
              );
            }
          }
        }
      },
    );
  }

//判断是否需要展示时间标签
  bool _isNeedToshowTimeLabel(int index) {
    if (index == 0) {
      return true;
    } else {
      TLDMessageModel lastModel = _dataSource[index - 1];
      TLDMessageModel currentModel = _dataSource[index];
      return currentModel.createTime - lastModel.createTime > 30000;
    }
  }

  Widget _getBody(BuildContext context) {
    return Column(
      children: <Widget>[
        TLDIMHeaderView(),
        Expanded(
          child: _getFreshWidget(context),
        ),
        TLDInputView(
          orderNo: widget.orderNo,
          selfAddress: widget.selfWalletAddress,
          otherGuyAddress: widget.otherGuyWalletAddress,
          beginEditingCallBack: () {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          },
          didClickCameraBtnCallBack: () {
            _takePhoto();
          },
          didClickPhotoBtnCallBack: () {
            _openGallery();
          },
        ),
      ],
    );
  }
}
