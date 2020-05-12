import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/View/tld_import_purse_input_word_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_import_purse_input_word_view.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import 'tld_import_purse_success_page.dart';

class TLDImportPurseWordPage extends StatefulWidget {
  TLDImportPurseWordPage({Key key}) : super(key: key);

  @override
  _TLDImportPurseWordPageState createState() => _TLDImportPurseWordPageState();
}

class _TLDImportPurseWordPageState extends State<TLDImportPurseWordPage> {
  List words;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    words = [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(40)),
          child: Text('按照下面的顺序抄下12个助记词',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        TLDImportPurseInputWordView(
          textFieldEditingWithIndexCallBack: (String text, int index) {
            words[index] = text;
          },
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(150),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                '确定',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                bool isEmpty = false;
                for (String word in words) {
                  if (word.length == 0 || word == null) {
                    isEmpty = true;
                    break;
                  }
                }
                if (isEmpty) {
                  showDialog(context: context , builder : (context) => TLDAlertView(title : '温馨提示',type : TLDAlertViewType.normal ,alertString: '需要将助记词补满哦',didClickSureBtn: (){},));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TLDImportPurseSuccessPage()));
                }
              }),
        )
      ],
    )
    );
  }
}
