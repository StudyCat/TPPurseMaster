
// import 'package:web3dart/credentials.dart';
import 'dart:async';
import 'dart:convert';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import '../../../dataBase/tld_database_manager.dart';
import 'dart:typed_data';
import 'package:web3dart/crypto.dart';

class TLDCreatePurseModelManager {

  Future createPurse(String password, Function(TLDWallet) success) async {
    TLDWallet wallet = await _getWalletWithNoting();
    await _insertDB(wallet);
    success(wallet);
  }

  Future importPurseWithWord(String mnemonicString,Function(TLDWallet) success,Function failure) async {
    TLDWallet wallet = await _getWalletWithWord(mnemonicString);
    if (await _isHaveSamePurse(wallet)){
      failure();
    }else{
      await _insertDB(wallet);
      success(wallet);
    }
  }

   Future importPurseWithPrivateKey(String privateKey,Function(TLDWallet) success,Function failure) async {
    TLDWallet wallet = await _getWalletWithPrivateKey(privateKey);
     if (await _isHaveSamePurse(wallet)){
      failure();
    }else{
      await _insertDB(wallet);
      success(wallet);
    }
  }



  Future _insertDB(TLDWallet tldWallet) async {
    TLDDataBaseManager manager = TLDDataBaseManager();
    await manager.openDataBase();
    await manager.insertDataBase(tldWallet);
    await manager.close();
  }

  Future<TLDWallet> _getWalletWithNoting() async{
    String randomMnemonic =  bip39.generateMnemonic();
    String seed = bip39.mnemonicToSeedHex(randomMnemonic);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
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
    TLDWallet tldWallet = TLDWallet(null, walletJson, randomMnemonic,privateKey,addressHex);
    return tldWallet;
  }

  Future<TLDWallet> _getWalletWithWord(String mnemonicString) async{
     String seed = bip39.mnemonicToSeedHex(mnemonicString);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
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
    TLDWallet tldWallet = TLDWallet(null, walletJson, mnemonicString,privateKey,addressHex);
    return tldWallet;
  }

    Future<TLDWallet> _getWalletWithPrivateKey(String privateKey) async{
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
    TLDWallet tldWallet = TLDWallet(null, walletJson, '',privateKey,addressHex);
    return tldWallet;
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
    await dataBase.close();
    return purses;
  }


}
