import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDEmptyListView extends StatefulWidget {
  TLDEmptyListView({Key key,@required this.getListViewCellCallBack,@required this.getEmptyViewCallBack,@required this.streamController,this.refreshController,this.refreshCallBack,this.loadCallBack}) : super(key: key);
  
  final Widget Function(int index) getListViewCellCallBack;

  final Widget Function() getEmptyViewCallBack;

  final StreamController streamController;

  final RefreshController refreshController;

  final Function refreshCallBack;

  final Function loadCallBack;

  @override
  _TLDEmptyListViewState createState() => _TLDEmptyListViewState();
}

class _TLDEmptyListViewState extends State<TLDEmptyListView> {
  bool _isNeedRefreh;
  bool _isNeedLoad;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isNeedRefreh = widget.refreshController != null ? true : false;
    _isNeedLoad = widget.refreshController != null ? true : false;
  }

  @override
  void dispose() { 
    widget.streamController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.streamController.stream ,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot){
        List dataList = snapshot.data;
        if (dataList.length > 0){
          return _haveDataViewBuild(dataList);
        }else{
          return _emptyDataViewBuild();
        }
      },
    );
  }

  Widget _listViewBuild(List dataList){
    return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
            return widget.getListViewCellCallBack(index);
           }
    );
  }

  Widget _haveDataViewBuild(List dataList){
    if (_isNeedRefreh == true){
      if (_isNeedLoad == true){
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: widget.refreshController,
          onRefresh: widget.refreshCallBack,
          onLoading: widget.loadCallBack,
          header: _refreshHeaderBuild(),
          footer: _loadFooterBuild(),
          child: _listViewBuild(dataList),
        );
      }else{
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: widget.refreshController,
          onRefresh: widget.refreshCallBack,
          header: _refreshHeaderBuild(),
          child: _listViewBuild(dataList),
        );
      }
    }else{
      if (_isNeedLoad == true){
        return SmartRefresher(
          enablePullUp: true,
          enablePullDown: false,
          controller: widget.refreshController,
          onLoading: widget.loadCallBack,
          footer: _loadFooterBuild(),
          child: _listViewBuild(dataList),
        );
      }else{
        return _listViewBuild(dataList);
      }
    }
  }

  Widget _emptyDataViewBuild(){
    if (_isNeedRefreh == true){
      if (_isNeedLoad == true){
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: widget.refreshController,
          onRefresh: widget.refreshCallBack,
          onLoading: widget.loadCallBack,
          header: _refreshHeaderBuild(),
          footer: _loadFooterBuild(),
          child: widget.getEmptyViewCallBack(),
        );
      }else{
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: widget.refreshController,
          onRefresh: widget.refreshCallBack,
          header: _refreshHeaderBuild(),
          child: widget.getEmptyViewCallBack(),
        );
      }
    }else{
      if (_isNeedLoad == true){
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: widget.refreshController,
          onLoading: widget.loadCallBack,
          footer: _loadFooterBuild(),
          child: widget.getEmptyViewCallBack(),
        );
      }else{
        return widget.getEmptyViewCallBack();
      }
    }
  }


  Widget _refreshHeaderBuild(){
    return WaterDropHeader(
      complete : Text('刷新完成')
    );
  }

  Widget _loadFooterBuild(){
    return CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("放下加载更多数据");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        );
  }
}