import 'package:dragon_sword_purse/Base/tld_base_request.dart';

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

class TLDFindRootCellUIModel {
  String title;
  List items;
  TLDFindRootCellUIModel({this.title, this.items});
}

class TLDFindRootCellUIItemModel {
  String title = '';
  String imageAssest;
  bool isPlusIcon = false;
  TLDFindRootCellUIItemModel({this.imageAssest, this.title, this.isPlusIcon});
}

class TLDFindRootModelManager {
  static List get uiModelList {
    return [
      TLDFindRootCellUIModel(title: '玩法', items: [
        TLDFindRootCellUIItemModel(
            title: 'TLD票据', imageAssest: 'assetss/images/icon_choose_accept.png',isPlusIcon: false),
        TLDFindRootCellUIItemModel(
            title: '任务', imageAssest: 'assetss/images/icon_choose_mission.png',isPlusIcon: false),
        TLDFindRootCellUIItemModel(title: '', imageAssest: '',isPlusIcon: true)
      ]),
      TLDFindRootCellUIModel(title: '其他', items: [
        TLDFindRootCellUIItemModel(
            title: '排行榜', imageAssest: 'assetss/images/icon_choose_rank.png',isPlusIcon: false),
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
}
