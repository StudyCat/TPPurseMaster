import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:web3dart/credentials.dart';

final String tableWallet = 'wallet';
final String walletId = '_id';
final String walletJson = 'walletJson';
final String walletMnemonic = 'walletMnemonic';
final String walletPrivate = 'walletPrivate';
final String walletAdress = 'walletAdress';
final String walletName = 'walletName';

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
  Database db;


  openDataBase() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    //根据数据库文件路径和数据库版本号创建数据库表
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
    });
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

   close() async {
    await db.close();
  }
  
  }
