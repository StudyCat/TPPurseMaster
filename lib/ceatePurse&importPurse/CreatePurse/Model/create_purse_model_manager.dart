
// import 'package:web3dart/credentials.dart';
import 'dart:async';
import 'dart:convert';
import 'package:bip39/bip39.dart' as bip39;
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import '../../../dataBase/tld_database_manager.dart';
import 'dart:typed_data';
import 'package:web3dart/crypto.dart';
import '../../../Base/tld_base_request.dart';

class TLDCreatePurseModelManager {
  Future createPurse(String password, Function(TLDWallet) success,Function(TLDError) failure) async {
    TLDWallet wallet = await _getWalletWithNoting();
    createServiceWallet(wallet, (TLDWallet wallet)async{
      await _insertDB(wallet);
      success(wallet);
    }, (error) => failure(error));
  }

  Future importPurseWithWord(String mnemonicString,Function(TLDWallet) success,Function(TLDError) failure) async {
    TLDWallet wallet = await _getWalletWithWord(mnemonicString);
    if (await _isHaveSamePurse(wallet)){
      failure(TLDError(800,'已拥有该钱包'));
    }else{
      searchPurseIsExist(wallet.address, ()async{
        await _insertDB(wallet);
        success(wallet);
      }, (error) => failure(error));
    }
  }

   Future importPurseWithPrivateKey(String privateKey,Function(TLDWallet) success,Function(TLDError) failure) async {
    TLDWallet wallet = await _getWalletWithPrivateKey(privateKey);
     if (await _isHaveSamePurse(wallet)){
       failure(TLDError(800,'已拥有该钱包'));
    }else{
       searchPurseIsExist(wallet.address, ()async{
        await _insertDB(wallet);
        success(wallet);
      }, (error) => failure(error));
    }
  }



  Future _insertDB(TLDWallet tldWallet) async {
    TLDDataBaseManager manager = TLDDataBaseManager();
    await manager.openDataBase();
    await manager.insertDataBase(tldWallet);
    await manager.closeDataBase();
  }

  Future<TLDWallet> _getWalletWithNoting() async{
    String randomMnemonic =  bip39.generateMnemonic();
    String seed = bip39.mnemonicToSeedHex(randomMnemonic);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
    return await _getWallet(privateKey,randomMnemonic);
  }

  Future<TLDWallet> _getWallet(String privateKey,String mnemonic) async{
    EthPrivateKey private = EthPrivateKey.fromHex(privateKey);
    EthereumAddress address = await private.extractAddress();
    Uint8List addressList = address.addressBytes;
    String addressHex = bytesToHex(
                      addressList,                           //地址字节数组
                      include0x:true,                    //包含0x前缀
                      forcePadLength:40                  //补齐到40字节
                    );
    Random rng = Random.secure();
    Wallet wallet = Wallet.createNew(private, '', rng);
    String walletJson = wallet.toJson();
    Map walletMap = jsonDecode(walletJson);
    String walletId = walletMap['id'];
    String walletName = '屠龙刀钱包' + walletId.split('-').first;
    TLDWallet tldWallet = TLDWallet(null, walletJson, mnemonic,privateKey,addressHex,walletName);
    return tldWallet;
  }

  Future<TLDWallet> _getWalletWithWord(String mnemonicString) async{
    String seed = bip39.mnemonicToSeedHex(mnemonicString);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
    return await _getWallet(privateKey, mnemonicString);
  }

    Future<TLDWallet> _getWalletWithPrivateKey(String privateKey) async{
    return await _getWallet(privateKey, '');
  }


  Future<bool> _isHaveSamePurse(TLDWallet wallet) async{
     List purses = await _getAllPurse();

    if (purses != null){
      List wallletIds = [];
     for (TLDWallet item in purses) {
       wallletIds.add(item.address);
     }
      return wallletIds.contains(wallet.address);
    }else{
      return false;
    }
  }

  Future<List> _getAllPurse() async{
    TLDDataBaseManager dataBase = TLDDataBaseManager();
    await dataBase.openDataBase();
    List purses = await dataBase.searchAllWallet();
    await dataBase.closeDataBase();
    return purses;
  }


  void createServiceWallet(TLDWallet wallet,Function(TLDWallet) success,Function(TLDError) failure){
    String walletAddree = wallet.address;
    String registorId = TLDDataManager.instance.registrationID;
    Map pramater;
    if (registorId.length == 0){
      pramater = {'walletAddress':walletAddree};
    }else{
      pramater = {'walletAddress':walletAddree,'registrationId':registorId};
    }
    TLDBaseRequest request = TLDBaseRequest(pramater,'wallet/createWallet');
    request.postNetRequest((dynamic data) {
      success(wallet);
      } , (TLDError error){
        failure(error);
        } );
  }

  void searchPurseIsExist(String walletAddress,Function success,Function(TLDError) failure){
      List addressList = [walletAddress];
      String addressListJson = jsonEncode(addressList);
      TLDBaseRequest request = TLDBaseRequest({"list":addressListJson}, 'wallet/queryWallet');
      request.postNetRequest((dynamic data) {
      success();
       }, (error)=> failure(error));
  }

}
