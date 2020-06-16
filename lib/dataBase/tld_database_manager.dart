import 'dart:convert';
import 'dart:typed_data';

import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:web3dart/credentials.dart';
import 'package:file_picker/file_picker.dart';

final String tableWallet = 'wallet';
final String walletId = '_id';
final String walletJson = 'walletJson';
final String walletMnemonic = 'walletMnemonic';
final String walletPrivate = 'walletPrivate';
final String walletAdress = 'walletAdress';
final String walletName = 'walletName';

final String tableIM = 'imtable';
final String contentTypeIM = 'contentType';
final String contentIM = 'content';
final String fromIM = 'fromAddress';
final String toIM = 'toAddress';
final String unreadIM = 'unread';
final String createTimeIM = 'createTime';
final String idIM = '_id';
final String orderNoIM = 'orderNo';
final String messageTypeIM = 'messageType';
final String bizAttrIM = 'bizAttr';

class TLDWallet{
  int id;
  String json;
  String mnemonic;
  String privateKey;
  String address;
  String name;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      walletJson: json,
      walletMnemonic: mnemonic,
      walletPrivate : privateKey,
      walletAdress : address,
      walletName : name
    };
    if (id != null) {
      map[walletId] = id;
    }
    return map;
  }

  TLDWallet(int id, String json, String mnemonic,String privateKey,String address,String name) {
    this.id = id;
    this.json = json;
    this.mnemonic = mnemonic;
    this.privateKey = privateKey;
    this.address = address;
    this.name = name;
  }

  TLDWallet.fromMap(Map<String, dynamic> map) {
    id = map[walletId];
    json = map[walletJson];
    mnemonic = map[walletMnemonic];
    privateKey = map[walletPrivate];
    address = map[walletAdress];
    name = map[walletName];
  }
}

class TLDDataBaseManager {

  // 工厂模式
  factory TLDDataBaseManager() =>_getInstance();
  static TLDDataBaseManager get instance => _getInstance();
  static TLDDataBaseManager _instance;
  TLDDataBaseManager._internal(){
    // 初始化
     
  }
  static TLDDataBaseManager _getInstance() {
    if (_instance == null) {
      _instance = new TLDDataBaseManager._internal();
    }
    return _instance;
  }

  Database db;
  

  openDataBase() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'TLDDollar.db');

    //根据数据库文件路径和数据库版本号创建数据库表
    if (db == null){
      db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableWallet (
            $walletId INTEGER PRIMARY KEY, 
            $walletJson TEXT, 
            $walletMnemonic TEXT,
            $walletPrivate TEXT,
            $walletAdress TEXT,
            $walletName TEXT)
          ''');
       await db.execute('''
          CREATE TABLE $tableIM (
            $idIM INTEGER PRIMARY KEY, 
            $contentTypeIM INTEGER, 
            $contentIM LONGTEXT,
            $fromIM TEXT,
            $toIM TEXT,
            $unreadIM INTEGER,
            $createTimeIM INTEGER,
            $orderNoIM TEXT,
            $messageTypeIM INTEGER,
            $bizAttrIM TEXT)
          ''');    
    });
    }
  }

  closeDataBase()async{
    if (db.isOpen){
      // await db.close();
    }
  }


  Future insertIMDataBase(List messageList) async{
    for (TLDMessageModel model in messageList) {
        if (model.contentType == 2){
          String filePath = await this._saveImageFileInMemory(model.content);
          model.content = filePath;
        }
    }

    String valuesStr = '';
    for (int i = 0; i < messageList.length ; i++) {
      TLDMessageModel model = messageList[i];
      int unread = model.unread ? 1 : 0;
      String str1 = '(\"'+model.content+'\",'+ '${model.contentType}'+',\"'+model.fromAddress+'\",\"'+model.toAddress+'\",'+'$unread'+',';
      String str2 = '${model.createTime}'+ ',\"' + model.orderNo +'\",'+'${model.messageType}'+',\''+ model.bizAttr +'\''+')';
      String str = str1 + str2;
      if(i == 0){
        valuesStr = str;
      }else{
        valuesStr = valuesStr + ',' + str;
      }
    }
    String sql = 'INSERT INTO $tableIM($contentIM,$contentTypeIM,$fromIM,$toIM,$unreadIM,$createTimeIM,$orderNoIM,$messageTypeIM,$bizAttrIM) VALUES'+valuesStr;
    await db.rawInsert(sql);
  }

  //存储Base64图片到本地，存储本地路径
  Future<String> _saveImageFileInMemory(String base64ImageString) async{
    Uint8List imageByteList = base642Image(base64ImageString);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String floderPath = appDocPath+"/"+"IM";
    var file = Directory(floderPath);
    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
      }
    } catch (e) {
      print(e);
    }
    String filePath =  floderPath +'/'+ base64ImageString.substring(0,20) + '.png';
    var pngFile = File(filePath);
    await pngFile.writeAsBytes(imageByteList);
    return filePath;
  }

//搜索历史消息（通过orderNo为条件）
  Future<List> searchIMDataBase(String orderNo,int page) async{
    int pageLimit = page * 10;
    List<Map> maps = await db.rawQuery('SELECT * FROM $tableIM WHERE $orderNoIM = \"$orderNo\" AND $messageTypeIM = 2 ORDER BY _id DESC LIMIT $pageLimit,10');
     if (maps == null || maps.length == 0) {
      return [];
    }

    List<TLDMessageModel> messages = [];
    for (int i = 0; i < maps.length; i++) {
      messages.insert(0, TLDMessageModel.fromJson(maps[i]));
    }
    return messages;
  }

  Future<List> searchSystemIMDataBase(int page) async{
    int pageLimit = page * 10;
    List<Map> maps = await db.rawQuery('SELECT * FROM $tableIM WHERE  $messageTypeIM = 1 ORDER BY _id DESC LIMIT $pageLimit,10');
     if (maps == null || maps.length == 0) {
      return [];
    }

    List<TLDMessageModel> messages = [];
    for (int i = 0; i < maps.length; i++) {
      messages.insert(0, TLDMessageModel.fromJson(maps[i]));
    }
    return messages;
  }

  //进入到聊天界面后把所有未读消息置位已读
  updateUnreadMessageType(String orderNo) async{
    await db.rawUpdate('UPDATE  $tableIM SET $unreadIM = 0 WHERE $orderNoIM = \"$orderNo\" AND $messageTypeIM = 2');
  }

  //进入系统消息界面后吧所有系统消息置位已读
  updateUnreadSystemMessageType() async{
    await db.rawUpdate('UPDATE  $tableIM SET $unreadIM = 0 WHERE  $messageTypeIM = 1');
  }


//搜寻所有未读消息
  Future<List> searchUnReadMessageList()async{
    if (!db.isOpen){
      await openDataBase();
    }
     List maps = await db.rawQuery('SELECT * FROM $tableIM WHERE $unreadIM = 1');
     if (maps == null || maps.length == 0) {
      return [];
    }

    List<TLDMessageModel> messages = [];
    for (int i = 0; i < maps.length; i++) {
      messages.insert(0, TLDMessageModel.fromJson(maps[i]));
    }
    return messages;
  }

  //搜索数据库中以orderNo分组的IM聊天
  Future<List> searchOrderNoChatGroup() async{
    List<Map> maps = await db.rawQuery('SELECT * FROM $tableIM as m1 WHERE m1._id IN(SELECT max(_id) from $tableIM GROUP BY $orderNoIM) AND $messageTypeIM = 2 GROUP BY m1.$orderNoIM');
     if (maps == null || maps.length == 0) {
      return [];
    }

    List<TLDMessageModel> messages = [];
    for (int i = 0; i < maps.length; i++) {
      messages.insert(0, TLDMessageModel.fromJson(maps[i]));
    }
    return messages;
  }
  
  //搜索数据库中以fromAdress分组IM的分组
  Future<List> searchFromAddressChatGroup()async{
    List purseList = TLDDataManager.instance.purseList;
    String sqlPurseStr = '';
    for (int i = 0; i < purseList.length ; i++) {
      TLDWallet wallet = purseList[i];
    if (i == 0){
        sqlPurseStr = '\"' +wallet.address + '\"';
      }else{
        sqlPurseStr = sqlPurseStr +','+ '\"'+wallet.address+'\"';
      }
    }

    List<Map> maps = await db.rawQuery('SELECT	m1.* FROM $tableIM as m1  WHERE m1._id in ( SELECT max(_id) from $tableIM GROUP BY $fromIM) AND m1.$fromIM IN ($sqlPurseStr) GROUP BY m1.$toIM');
     if (maps == null || maps.length == 0) {
      return [];
    }

    List<TLDMessageModel> messages = [];
    for (int i = 0; i < maps.length; i++) {
      messages.insert(0, TLDMessageModel.fromJson(maps[i]));
    }
    return messages;
  }

  //搜索数据库中以toAdress分组IM的分组
  Future<List> searchToAddressChatGroup()async{
    List purseList = TLDDataManager.instance.purseList;
    String sqlPurseStr = '';
    for (int i = 0; i < purseList.length ; i++) {
      TLDWallet wallet = purseList[i];
      if (i == 0){
        sqlPurseStr = '\"' +wallet.address + '\"';
      }else{
        sqlPurseStr = sqlPurseStr +','+ '\"'+wallet.address+'\"';
      }
    }

    List<Map> maps = await db.rawQuery('SELECT m1.* FROM $tableIM as m1 WHERE  m1.$toIM IN ($sqlPurseStr) AND  m1._id in ( SELECT max(_id) from $tableIM  GROUP BY $fromIM)  GROUP BY m1.$fromIM');
     if (maps == null || maps.length == 0) {
      return [];
    }

    List<TLDMessageModel> messages = [];
    for (int i = 0; i < maps.length; i++) {
      messages.insert(0, TLDMessageModel.fromJson(maps[i]));
    }
    return messages;
  }

  Future<TLDWallet> insertDataBase(TLDWallet wallet) async {
    wallet.id = await db.insert(tableWallet, wallet.toMap());
    return wallet;
  }

   deleteDataBase(TLDWallet wallet) async{
     await db.delete(tableWallet,where:'$walletId = ${wallet.id}');
  }

  changeWalletName(TLDWallet wallet) async{
    await db.update(tableWallet, wallet.toMap(),where: '$walletId = ${wallet.id}');
  }

  Future<List> searchAllWallet() async{
    List<Map> maps = await db.query(tableWallet,columns: [
      walletId,
      walletJson,
      walletMnemonic,
      walletPrivate,
      walletAdress,
      walletName
    ]);

     if (maps == null || maps.length == 0) {
      return null;
    }

    List<TLDWallet> tldWallet = [];
    for (int i = 0; i < maps.length; i++) {
      tldWallet.add(TLDWallet.fromMap(maps[i]));
    }
    return tldWallet;
  }

  
  }
