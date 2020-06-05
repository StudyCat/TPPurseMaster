import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Purse/FirstPage/View/message_button.dart';
import 'IMUI/Page/tld_im_page.dart';
import 'Message/Page/tld_message_page.dart';
import 'ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'CommonFunction/tld_common_function.dart';
import 'ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import 'ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';

class TLDNotPurseHomePage extends StatefulWidget {
  TLDNotPurseHomePage({Key key}) : super(key: key);

  @override
  _TLDNotPurseHomePageState createState() => _TLDNotPurseHomePageState();
}

class _TLDNotPurseHomePageState extends State<TLDNotPurseHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {});
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(didClickCallBack: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TLDMessagePage()));
        }),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(130)),
          child: Image.asset(
            'assetss/images/no_purse_page_icon.png',
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(200),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
          child: Text('您还没有天和钱包',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(70),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: (size.width - ScreenUtil().setWidth(220)) / 2,
                height: ScreenUtil().setHeight(80),
                child: _getActionButton('创建钱包', () {
                  _createPurse(context);
                }),
              ),
              Container(
                width: (size.width - ScreenUtil().setWidth(220)) / 2,
                height: ScreenUtil().setHeight(80),
                child: _getActionButton('导入钱包', () {
                  _importPurse(context);
                }),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(70),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.white),
              child: Text(
                '温馨提示:\n    冷钱包创建在手机端本地。创建钱包会要求您输入钱包密码，钱包会生成您用来恢复钱包的助记词，签名用的私钥，加密和验签用的公钥，以及钱包地址。\n   请妥善保管好您的助记词和私钥。',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 153, 153, 153)),
              )),
        )
      ],
    ));
  }

  Widget _getActionButton(String title, Function didClickCallBack) {
    return CupertinoButton(
        child: Text(
          title,
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
        ),
        padding: EdgeInsets.all(0),
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        onPressed: didClickCallBack);
  }

  void _createPurse(BuildContext context) {
    jugeHavePassword(context, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TLDCreatingPursePage(
                    type: TLDCreatingPursePageType.create,
                  )));
    }, TLDCreatePursePageType.create, null);
  }

  void _importPurse(BuildContext context) {
    jugeHavePassword(context, () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TLDImportPursePage()));
    }, TLDCreatePursePageType.import, null);
  }
}
