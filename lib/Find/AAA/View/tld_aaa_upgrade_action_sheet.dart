import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_person_center_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum TLDAAAUpgradeType { noraml, all }

class TLDAAAUpgradeActionSheet extends StatefulWidget {
  TLDAAAUpgradeActionSheet({Key key,this.didClickUpgrade,this.upgradeInfoModel}) : super(key: key);

  final TLDAAAUpgradeInfoModel upgradeInfoModel;

  final Function didClickUpgrade;

  @override
  _TLDAAAUpgradeActionSheetState createState() =>
      _TLDAAAUpgradeActionSheetState();
}

class _TLDAAAUpgradeActionSheetState extends State<TLDAAAUpgradeActionSheet> {
  TLDAAAUpgradeType _type = TLDAAAUpgradeType.all;

  String _walletAddress;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        //showModalBottomSheet 键盘弹出时自适应
        padding: MediaQuery.of(context).viewInsets, //边距（必要）
        duration: const Duration(milliseconds: 100), //时常 （必要）
        child: Container(
            // height: 180,
            constraints: BoxConstraints(
              minHeight: 90.w, //设置最小高度（必要）
              maxHeight: MediaQuery.of(context).size.height / 1.5, //设置最大高度（必要）
            ),
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: ListView(shrinkWrap: true, //防止状态溢出 自适应大小
                children: <Widget>[
                  Column(children: <Widget>[
                    Container(
                      color: Color.fromARGB(255, 242, 242, 242),
                      height: ScreenUtil().setHeight(80),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('升级',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Color.fromARGB(255, 51, 51, 51))),
                      ),
                    ),
                    _levelWidget(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder : (context) => TLDEchangeChooseWalletPage(
                            didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
                              setState(() {
                                _walletAddress = infoModel.walletAddress;
                              });
                            },
                          )
                        ));
                      },
                      child: _walletAddressWidget(_walletAddress == null ? '请选择钱包' : _walletAddress),
                    ),
                    _getChooseRedEnvelopeTypeWidget(),
                    _bottomWidget()
                  ])
                ])));
  }

  Widget _levelWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '恭喜您即将升级为V${widget.upgradeInfoModel.nextLevel}  ',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 74, 74, 74)),
            children: [
              WidgetSpan(
                  child: Container(
                width: ScreenUtil().setHeight(60),
                height: ScreenUtil().setHeight(60),
                child: CachedNetworkImage(
                  imageUrl:
                      widget.upgradeInfoModel.nextLevelIcon,
                  fit: BoxFit.fill,
                ),
              ))
            ]),
      ),
    );
  }

  Widget _walletAddressWidget(String content) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '支付钱包',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Row(children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(280),
                    child: Text(
                      content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 153, 153, 153)),
                    )),
                Icon(Icons.keyboard_arrow_right)
              ])
            ],
          )),
    );
  }

  Widget _getChooseRedEnvelopeTypeWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30), left: ScreenUtil().setWidth(30)),
      child: Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: _getSingleChoiceWidget(
              TLDAAAUpgradeType.noraml,
              '普通升级',
            )),
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: _getSingleChoiceWidget(
              TLDAAAUpgradeType.all,
              '全部升级',
            ))
      ]),
    );
  }

  Widget _getSingleChoiceWidget(TLDAAAUpgradeType type, String title) {
    return Row(children: <Widget>[
      Container(
        height: ScreenUtil().setHeight(18),
        width: ScreenUtil().setHeight(18),
        child: Radio(
          activeColor: Color.fromARGB(255, 51, 51, 51),
          focusColor: Color.fromARGB(255, 51, 51, 51),
          hoverColor: Color.fromARGB(255, 51, 51, 51),
          value: type,
          groupValue: _type,
          onChanged: (value) {
            setState(() {
              _type = value;
            });
          },
        ),
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
          child: GestureDetector(
            onTap: (){
              setState(() {
              _type = type;
            });
            },
            child : Text(
            title,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: ScreenUtil().setSp(24)),
          )
          ))
    ]);
  }

  Widget _bottomWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Container(
        height: ScreenUtil().setHeight(80),
        color: Color.fromARGB(255, 242, 242, 242),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: RichText(
                text: TextSpan(
                    text: _type == TLDAAAUpgradeType.noraml ? widget.upgradeInfoModel.nextTldCount : widget.upgradeInfoModel.fullTldCount,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
                        color: Color.fromARGB(255, 74, 74, 74),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: 'TLD',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromARGB(255, 155, 155, 155),
                          ))
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(260),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).hintColor,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  child: Text('确认升级',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Color.fromARGB(255, 51, 51, 51),
                      )),
                  onPressed: () {
                    if (_walletAddress == null){
                      Fluttertoast.showToast(msg: '请先选择钱包');
                      return;
                    }
                    int type = _type == TLDAAAUpgradeType.noraml ? 1 : 2;
                    widget.didClickUpgrade(type,_walletAddress);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
