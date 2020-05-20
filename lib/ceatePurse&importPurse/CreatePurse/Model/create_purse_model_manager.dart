
// import 'package:web3dart/credentials.dart';
import 'dart:async';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import '../../../dataBase/tld_database_manager.dart';

class TLDCreatePurseModelManager {

  Future createPurse(String password, Function success) async {
    TLDWallet wallet = await _getWallet();
    await _insertDB(wallet);
    success();
  }

  Future _insertDB(TLDWallet tldWallet) async {
    TLDDataBaseManager manager = TLDDataBaseManager();
    await manager.openDataBase();
    await manager.insertDataBase(tldWallet);
    await manager.close();
  }

  Future<TLDWallet> _getWallet() async{
    String randomMnemonic = bip39.generateMnemonic();
    String seed = bip39.mnemonicToSeedHex(randomMnemonic);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
    EthPrivateKey private = EthPrivateKey.fromHex(privateKey);
    Random rng = Random.secure();
    Wallet wallet = Wallet.createNew(private, '', rng);
    String walletJson = wallet.toJson();
    TLDWallet tldWallet = TLDWallet(null, walletJson, randomMnemonic);
    return tldWallet;
  }
}
