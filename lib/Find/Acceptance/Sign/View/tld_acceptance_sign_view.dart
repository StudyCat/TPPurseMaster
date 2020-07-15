
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_day_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';

class TLDAcceptanceSignView extends StatefulWidget {
  TLDAcceptanceSignView({Key key}) : super(key: key);

  @override
  _TLDAcceptanceSignViewState createState() => _TLDAcceptanceSignViewState();
}

class _TLDAcceptanceSignViewState extends State<TLDAcceptanceSignView> {

  CalendarController _calendarController;

  ValueNotifier<String> text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getController();

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

     _calendarController.addMonthChangeListener(
      (year, month) {
        text.value = "$year年$month月";
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        _getDateHeaderView(),
        _getDateView()
      ]
    );
  }


  void _getController(){
    _calendarController =  CalendarController(
      showMode: 1,
      offset : 0
    );
  }

  Widget _getDateView(){
    double size = (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 7;
    return CalendarViewWidget(
      itemSize: size,
      calendarController: _calendarController,
      weekBarItemWidgetBuilder: (){
        return Container();
      },
      dayWidgetBuilder: (DateModel model){
        TLDAcceptanceSignDayViewType type;
        if (model.isBefore(DateModel.fromDateTime(DateTime.now()))){
          type = TLDAcceptanceSignDayViewType.signComplete;
        }else if(model.isSameWith(DateModel.fromDateTime(DateTime.now()))){
          type = TLDAcceptanceSignDayViewType.signToday;
        }else{
          type = TLDAcceptanceSignDayViewType.signWait;
        }
        return TLDAcceptanceSignDayView(type : type, day: model.day);
      },

    );
  }

  Widget _getDateHeaderView(){
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: () {
                      _calendarController.moveToPreviousMonth();
                    }),
                ValueListenableBuilder(
                    valueListenable: text,
                    builder: (context, value, child) {
                      return new Text(text.value,style: TextStyle(fontSize:ScreenUtil().setSp(32),color: Theme.of(context).hintColor),);
                    }),
                new IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      _calendarController.moveToNextMonth();
                    }),
              ],
            );
  }

}