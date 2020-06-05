
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  TLDIMPage({Key key}) : super(key: key);

  @override
  _TLDIMPageState createState() => _TLDIMPageState();
}

class _TLDIMPageState extends State<TLDIMPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
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

  Widget _getBody(BuildContext context){
    return Column(
      children :<Widget>[
        TLDIMHeaderView(),
        Expanded(child: ListView.builder(
          itemCount: 40,
          itemBuilder: (BuildContext context, int index) {
          if (index % 8 == 0) {
            return TLDIMOtherUserWordMessageCell();
          }else if (index % 8 == 1){
            return TLDIMUserWordMessageCell();
          }else if(index % 8 == 2){
            return TLDIMOtherUserTimeWordMessageCell();
          }else if(index % 8 == 3){
            return TLDIMUserTimeWordMessageCell();
          }else if (index % 8 == 4){
            return TLDIMOtherUserImageMessageCell();
          }else if (index % 8 == 5){
            return TLDIMUserImageMessageCell();
          }else if (index % 8 == 6){
            return TLDIMUserTimeImageMessageCell();
          }else{
            return TLDIMOtherUserTimeImageMessageCell();
          }
         },
        ),),
        TLDInputView(),
      ],
    );
  }  
}