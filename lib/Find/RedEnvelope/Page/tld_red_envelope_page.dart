import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Page/tld_recieve_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_detail_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_send_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_red_envelop_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class TLDRedEnvelopePage extends StatefulWidget {
  TLDRedEnvelopePage({Key key}) : super(key: key);

  @override
  _TLDRedEnvelopePageState createState() => _TLDRedEnvelopePageState();
}

class _TLDRedEnvelopePageState extends State<TLDRedEnvelopePage> {

  TLDRedEnvelopeModelManager _modelManager;

  List _dataSource = [];

  int _page = 1;

  RefreshController _refreshController = RefreshController(initialRefresh:true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDRedEnvelopeModelManager();
  }

  void _getRedEnvelopeList(int page){
    _modelManager.getRedEnvelopeList(page, (List result){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if(page == 1){
        _dataSource = [];
      }
      if(mounted){
        setState(() {
          _dataSource.addAll(result);
        });
      }
      if(result.length > 0){
        _page = page + 1;
      }
    }, (TLDError error){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).redEvelope,
        ),
        trailing: CupertinoButton(padding: EdgeInsets.zero,child: Text(I18n.of(context).redEnvelopeRecieveRecord,style: TextStyle(fontSize:ScreenUtil().setSp(28)),), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDRecieveRedEnvelopePage(),));
        }),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text(I18n.of(context).pullUpToLoad);
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text(I18n.of(context).dropDownToLoadMoreData);
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _page = 1;
        _getRedEnvelopeList(_page);
      },
      onLoading: () => _getRedEnvelopeList(_page),
    ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
         return Padding(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(10),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
            bottom: ScreenUtil().setHeight(20)
          ),
          child: Container(
            height : ScreenUtil().setHeight(96),
            child :CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).createPromotionRedEnvelope,style : TextStyle(
                fontSize : ScreenUtil().setSp(30),
                color :Theme.of(context).hintColor
              )),
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDSendRedEnvelopePage())).then((value){
                  _refreshController.requestRefresh();
                  _page = 1;
                  _getRedEnvelopeList(_page);
                });
              }),
          )
        );
        }else{
          TLDRedEnevelopeListModel model = _dataSource[index - 1];
          return GestureDetector(
            onTap : (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailRedEnvelopePage(redEnvelopeId: model.redEnvelopeId,)));
            },
            child : TLDRedEnvelopeCell(listModel: model,)
          );
        }
     },
    );
  }

}