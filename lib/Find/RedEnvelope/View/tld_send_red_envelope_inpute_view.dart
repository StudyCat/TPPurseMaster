import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

enum TLDRedEnvelopType{
  spellLuck,
  quota
}

class TLDSendRedEnvelopeInputeView extends StatefulWidget {
  TLDSendRedEnvelopeInputeView({Key key}) : super(key: key);

  @override
  _TLDSendRedEnvelopeInputeViewState createState() => _TLDSendRedEnvelopeInputeViewState();
}

class _TLDSendRedEnvelopeInputeViewState extends State<TLDSendRedEnvelopeInputeView> {

  TLDRedEnvelopType _type;

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10)),
       child:   Container(
         padding : EdgeInsets.only(left : ScreenUtil().setWidth(10),right: ScreenUtil().setWidth(10),top: ScreenUtil().setHeight(10),bottom: ScreenUtil().setHeight(30)),
         decoration: BoxDecoration(
           color : Color.fromARGB(255, 210, 49, 67),
           borderRadius: BorderRadius.all(Radius.circular(4)),
         ),
         child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             _getTotalAmountTextField(),
             _getRedEnvelopNumberTextField(),
             _getRedEnvelopeDescriptionTextField(),
             _getChooseRedEnvelopeTypeWidget(),
             Padding(
               padding:EdgeInsets.only(
               top : ScreenUtil().setHeight(32),),
              child :Container(
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
                child: Text("10000TLD",textAlign: TextAlign.center,style: TextStyle(
                  color : Colors.white,
                  fontSize : ScreenUtil().setSp(72)
                ),),
              )
             )
           ],
         ),
       ),
    );
  }
  
  Widget _getTotalAmountTextField(){
    return Container(
      decoration: BoxDecoration(color : Colors.white,borderRadius : BorderRadius.all(Radius.circular(4))),
      height : ScreenUtil().setHeight(88),
      child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children : <InlineSpan>[
              WidgetSpan(
                child : Icon(IconData(0xe6ac,fontFamily : 'appIconFonts'),color: Theme.of(context).hintColor,size: ScreenUtil().setSp(30),),
              ),
              TextSpan(
                text : "  " + I18n.of(context).totalAmount,
                style: TextStyle(fontSize : ScreenUtil().setSp(30),fontWeight :FontWeight.bold,color: Color.fromARGB(255, 51, 51, 51)),
              )
            ]
          ),
        ),
        Expanded(
          // padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
          child: CupertinoTextField(
            decoration:BoxDecoration(border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
            placeholder: I18n.of(context).pleaseEnterRedEnvelopeAmount,
            inputFormatters: [TLDAmountTextInputFormatter()],
            placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),
            textAlign: TextAlign.right,
            style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),
          ),
        )
      ],
    )
    );
  }

  Widget _getRedEnvelopNumberTextField(){
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      child: Container(
        decoration: BoxDecoration(color : Colors.white,borderRadius : BorderRadius.all(Radius.circular(4))),
        height : ScreenUtil().setHeight(88),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(I18n.of(context).redEnvelopeNumber,
                style: TextStyle(fontSize : ScreenUtil().setSp(30),fontWeight :FontWeight.bold,color: Color.fromARGB(255, 51, 51, 51)),),
        _getNumberRowTextField(),
      ],
    ),
    ),
    );
  }

  Widget _getRedEnvelopeDescriptionTextField(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
      child: Container(
      decoration: BoxDecoration(color : Colors.white,borderRadius : BorderRadius.all(Radius.circular(4))),
      height: ScreenUtil().setHeight(136),
      child: CupertinoTextField(
                 decoration:BoxDecoration(border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                 placeholder: I18n.of(context).wishYouAProsperousLife,
                 placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),
                 keyboardType: TextInputType.number,
                 textAlign: TextAlign.center,
                 style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),
                ),
    ),
      );
  }


  Widget _getNumberRowTextField(){
    return Row(
      children: <Widget>[
        Container(
                  width : ScreenUtil().setWidth(150),
                  child : CupertinoTextField(
                 decoration:BoxDecoration(border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                 placeholder: I18n.of(context).enterNumber,
                 placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),
                 keyboardType: TextInputType.number,
                 textAlign: TextAlign.right,
                 style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),
                )
                ),
                Text( " " + I18n.of(context).entries,
          style: TextStyle(fontSize : ScreenUtil().setSp(30),fontWeight :FontWeight.bold,color: Color.fromARGB(255, 51, 51, 51))),
      ],
    );
  }

  Widget _getChooseRedEnvelopeTypeWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(32)),
      child: Row(
        children: <Widget>[Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(10)),
            child :_getSingleChoiceWidget(TLDRedEnvelopType.spellLuck, I18n.of(context).spellLuck),
        ),
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),
            child: _getSingleChoiceWidget(TLDRedEnvelopType.quota, I18n.of(context).quotaRedEnvelope),
          )
        ]
      ),
      );
  }

  Widget _getSingleChoiceWidget(TLDRedEnvelopType type,String title){
    return Row(children: <Widget>[
      Container(
        height : ScreenUtil().setHeight(18),
        width : ScreenUtil().setHeight(18),
        child: Radio(
        activeColor: Colors.white,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        value: type,
        groupValue: _type,
        onChanged: (value) {
          setState(() {
            _type = value;
          });
          // widget.didChooseCountCallBack(value);
        },
      ),
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(24)),
          ))
    ]);
  }

}

