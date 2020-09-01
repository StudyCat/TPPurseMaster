import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';

class TLDBannerModel {
  int bannerId;
  String bannerUrl;
  String bannerHref;
  int bannerSort;
  int createTime;
  bool valid;

  TLDBannerModel(
      {this.bannerId,
      this.bannerUrl,
      this.bannerHref,
      this.bannerSort,
      this.createTime,
      this.valid});

  TLDBannerModel.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    bannerUrl = json['bannerUrl'];
    bannerHref = json['bannerHref'];
    bannerSort = json['bannerSort'];
    createTime = json['createTime'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['bannerUrl'] = this.bannerUrl;
    data['bannerHref'] = this.bannerHref;
    data['bannerSort'] = this.bannerSort;
    data['createTime'] = this.createTime;
    data['valid'] = this.valid;
    return data;
  }
}

class TLD3rdWebInfoModel{
  String url;
  String iconUrl;
  String name;

   TLD3rdWebInfoModel(
      {this.url,
      this.iconUrl,
      this.name,});

  TLD3rdWebInfoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    iconUrl = json['iconUrl'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['iconUrl'] = this.iconUrl;
    data['name'] = this.name;
    return data;
  }
}

class TLDFindRootCellUIModel {
  String title;
  List items;
  TLDFindRootCellUIModel({this.title, this.items});
}

class TLDFindRootCellUIItemModel {
  String title;
  String imageAssest;
  bool isPlusIcon;
  String url;
  String iconUrl;
  TLDFindRootCellUIItemModel({this.imageAssest='', this.title='', this.isPlusIcon=false,this.url='',this.iconUrl=''});
}

class TLDFindRootModelManager {
  static List get uiModelList {
    return [
      TLDFindRootCellUIModel(title: I18n.of(navigatorKey.currentContext).playingMethodLabel, items: [
        TLDFindRootCellUIItemModel(
            title: I18n.of(navigatorKey.currentContext).tldBillLabel, imageAssest: 'assetss/images/icon_choose_accept.png',isPlusIcon: false),
        TLDFindRootCellUIItemModel(
            title: I18n.of(navigatorKey.currentContext).missionLabel, imageAssest: 'assetss/images/icon_choose_mission.png',isPlusIcon: false),
        TLDFindRootCellUIItemModel(title: '', imageAssest: '',isPlusIcon: true)
      ]),
      TLDFindRootCellUIModel(title: I18n.of(navigatorKey.currentContext).otherLabel, items: [
        TLDFindRootCellUIItemModel(
            title: I18n.of(navigatorKey.currentContext).rankLabel, imageAssest: 'assetss/images/icon_choose_rank.png',isPlusIcon: false),
      ])
    ];
  }

  void getBannerInfo(Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'banner/bannerList');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        result.add(TLDBannerModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void get3rdWebInfo(String qrCodeStr,Function(TLD3rdWebInfoModel) success,Function(TLDError) failure){
     try {
       if (qrCodeStr.contains('isTLD=true')){
        Uri uri = Uri.parse(qrCodeStr);
       String path = uri.path;
       String origin = uri.origin;
       String iconUrl = uri.queryParameters['iconUrl'];
       String name = uri.queryParameters['name'];
       TLD3rdWebInfoModel infoModel = TLD3rdWebInfoModel();
       infoModel.url = origin + path;
       infoModel.iconUrl = iconUrl;
       infoModel.name = name;
       success(infoModel);
       }else{
         TLDError error = TLDError(400,'无效的二维码');
       failure(error);
       }
     }catch(e){
       TLDError error = TLDError(400,'二维码解析失败');
       failure(error);
     }
  }
}
