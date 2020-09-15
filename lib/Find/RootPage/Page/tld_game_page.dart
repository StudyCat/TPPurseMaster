import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_ad_banner_view.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';



class TLDGamePage extends StatefulWidget {
  TLDGamePage({Key key}) : super(key: key);

  @override
  _TLDGamePageState createState() => _TLDGamePageState();
}

class _TLDGamePageState extends State<TLDGamePage> {
  List _bannerList = [];

  List _iconDataSource = [];

  TLDFindRootModelManager _modelManager;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager =  TLDFindRootModelManager();

    _getGameInfo();
  }

  void _getGameInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getGamePageInfo((List bannerList,List gameList){
      if (mounted){
        setState(() {
          _isLoading = false;
          _bannerList.addAll(bannerList);
          _dealGameList(gameList);
        });
      }
    }, (TLDError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _dealGameList(List gameList){
     List newWebList = [];
      for (TLD3rdWebInfoModel item in gameList) {
        TLDFindRootCellUIItemModel uiItemModel = TLDFindRootCellUIItemModel(title: item.name,iconUrl: item.iconUrl,url: item.url,isNeedHideNavigation: item.isNeedHideNavigation,appType: item.appType);
        newWebList.add(uiItemModel);
      }
     TLDFindRootCellUIModel findRootCellUIModel = TLDFindRootCellUIModel(title: I18n.of(context).game,items: newWebList,isHaveNotice: false);
     _iconDataSource.add(findRootCellUIModel);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child:  _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'game_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).game,),
        automaticallyImplyLeading: true,
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
    );
  }

  Widget _getBodyWidget(){
     return ListView.builder(
      itemCount: _iconDataSource.length + 1,
      itemBuilder: (context,index){
        if (index == 0){
          return TLDFindRootADBannerView(bannerList: _bannerList,didClickBannerViewCallBack: (TLDBannerModel bannerModel){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLD3rdPartWebPage(isNeedHideNavigation: !bannerModel.isNeedNavigation,urlStr: bannerModel.bannerHref,)));
          },);
        }else{
          TLDFindRootCellUIModel uiModel = _iconDataSource[index - 1];
          return TLDFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (TLDFindRootCellUIItemModel itemModel){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> TLD3rdPartWebPage(urlStr: itemModel.url,isNeedHideNavigation: itemModel.isNeedHideNavigation,)));
          },
          didLongClickItemCallBack: (TLDFindRootCellUIItemModel itemModel){

          },
          didClickQuestionItem: (){
            
          },
          );
        }
      });
  }

}