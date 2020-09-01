import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "TLD Wallet"
  String get commonPageTitle => "TLD Wallet";
  /// "Hint:\n      Wallet will create in app location.Create wallet needs input password,when wallet created it will create mnomic word,the private key for sign,the public key and wallet address.\n      Please save your mnomic word and private key"
  String get homePageNotice => "Hint:\n      Wallet will create in app location.Create wallet needs input password,when wallet created it will create mnomic word,the private key for sign,the public key and wallet address.\n      Please save your mnomic word and private key";
  /// "Create Wallet"
  String get createWalletBtnTitle => "Create Wallet";
  /// "Import Wallet"
  String get importWalletBtnTitle => "Import Wallet";
  /// "You don't have wallet yet"
  String get noWalletHint => "You don't have wallet yet";
  /// "Buy"
  String get buyBtnTitle => "Buy";
  /// "Search"
  String get searchBtnTitle => "Search";
  /// "Total Amount"
  String get totalAmountLabel => "Total Amount";
  /// "Remain Amount"
  String get remainAmountLabel => "Remain Amount";
  /// "Payment Method"
  String get paymentTermLabel => "Payment Method";
  /// "Minimum Purchase Amount"
  String get minimumPurchaseAmountLabel => "Minimum Purchase Amount";
  /// "Maximum Purchase Amount"
  String get maximumPurchaseAmountLabel => "Maximum Purchase Amount";
  /// "Please input TLD amount"
  String get buySearchFieldPlaceholder => "Please input TLD amount";
  /// "Address"
  String get addressLabel => "Address";
  /// "Notice"
  String get noticeTabLabel => "Notice";
  /// "System Message"
  String get systemMessageTabLabel => "System Message";
  /// "Message"
  String get messageTitle => "Message";
  /// "On Sale"
  String get onSaleTabTitle => "On Sale";
  /// "Wait Release"
  String get waitReleaseTabTitle => "Wait Release";
  /// "Sure rlease TLD success"
  String get sureReleaseTLDSuccessMessage => "Sure rlease TLD success";
  /// "You don't have order"
  String get noOrderLabel => "You don't have order";
  /// "Cancel Sale"
  String get cancelSaleBtnTitle => "Cancel Sale";
  /// "Order Number"
  String get orderNumLabel => "Order Number";
  /// "Sale Wallet"
  String get saleWalletLabel => "Sale Wallet";
  /// "Create Time"
  String get createTimeLabel => "Create Time";
  /// "Status"
  String get statusLabel => "Status";
  /// "On Sale"
  String get onSaleStatusLabel => "On Sale";
  /// "Finished"
  String get finishedStatusLabel => "Finished";
  /// "Canceled"
  String get canceledStatusLabel => "Canceled";
  /// "Service Charge Rate"
  String get serviceChargeRateLabel => "Service Charge Rate";
  /// "Service Charge"
  String get serviceChargeLabel => "Service Charge";
  /// "Anticipated To Account"
  String get anticipatedToAccount => "Anticipated To Account";
  /// "Find"
  String get findPageTitle => "Find";
  /// "TLD Bill"
  String get tldBillLabel => "TLD Bill";
  /// "Mission"
  String get missionLabel => "Mission";
  /// "Playing Method"
  String get playingMethodLabel => "Playing Method";
  /// "Other"
  String get otherLabel => "Other";
  /// "Rank"
  String get rankLabel => "Rank";
  /// "Mission is waiting develop,please expect"
  String get missionNotOpenAlertDesc => "Mission is waiting develop,please expect";
  /// "Haved same Application"
  String get haveSameApplicationAlertDesc => "Haved same Application";
  /// "Add third-party Application success"
  String get jointhirdPartyApplictionAlertDesc => "Add third-party Application success";
  /// "Real Payment"
  String get realPaymentLabel => "Real Payment";
  /// "Please input the amount"
  String get inputBuyAmountFieldPlaceholder => "Please input the amount";
  /// "Buy All"
  String get buyAllBtnTitle => "Buy All";
  /// "Receieve Address"
  String get receiveAddressLabel => "Receieve Address";
  /// " Please choose wallet"
  String get chooseWalletLabel => " Please choose wallet";
  /// "Place Order"
  String get placeOrderBtnTitle => "Place Order";
  /// "Count"
  String get countLabel => "Count";
  /// "Should Payment Amount"
  String get shouldPayAmountLabel => "Should Payment Amount";
  /// "Contact Seller"
  String get contactSellerLabel => "Contact Seller";
  /// "Contact Buyer"
  String get contactBuyerLabel => "Contact Buyer";
  /// "Cancel Order"
  String get cancelOrderBtnTitle => "Cancel Order";
  /// "Sure Payment"
  String get surePaymentBtnTitle => "Sure Payment";
  /// "Sure Realses TLD"
  String get sureReleaseTLDBtnTitle => "Sure Realses TLD";
  /// "Reminder"
  String get reminderBtnTitle => "Reminder";
  /// "Detail Order"
  String get detailOrderPageTitle => "Detail Order";
  /// "Appeal Order"
  String get appealOrderLabel => "Appeal Order";
  /// "Order Appealing"
  String get orderIsAppealingLabel => "Order Appealing";
  /// "Appeal Order Success"
  String get appealOrderSuccessLabel => "Appeal Order Success";
  /// "Appeal Order Failure"
  String get appealOrderFailureLabel => "Appeal Order Failure";
  /// "Cancel Withdraw"
  String get cancelWithdrawLabel => "Cancel Withdraw";
  /// "Wait Pay"
  String get waitPayLabel => "Wait Pay";
  /// "Have Paid"
  String get havePaidLabel => "Have Paid";
  /// "Overtime"
  String get overtimeLabel => "Overtime";
  /// "Appealing"
  String get appealingLabel => "Appealing";
  /// "Please pay the order until "
  String get pleasePayUntilLabel => "Please pay the order until ";
  /// " minute "
  String get payOrderMinuteLabel => " minute ";
  /// " second."
  String get payOrderSecondLabel => " second.";
  /// "Wait buyer payment"
  String get waitBuyerPaymentLabel => "Wait buyer payment";
  /// "Wait seller sure"
  String get waitSellerSureLabel => "Wait seller sure";
  /// "Order have canceled"
  String get orderHaveCanceledLabel => "Order have canceled";
  /// "Buying"
  String get buyingTabTitle => "Buying";
  /// "Sale"
  String get saleTabTitle => "Sale";
  /// "Detail"
  String get detailButtonTitle => "Detail";
  /// "OrderList"
  String get orderListPageTitle => "OrderList";
  /// "Amount"
  String get orderListAmountLabel => "Amount";
  /// "Release TLD"
  String get releaseTLDBtnTitle => "Release TLD";
  /// "Reset"
  String get resetBtnTitle => "Reset";
  /// "Sure"
  String get sureBtnTitle => "Sure";
  /// "Real Name"
  String get realNameLabel => "Real Name";
  /// "Bank Card Number"
  String get bankCardNumLabel => "Bank Card Number";
  /// "Open Account Bank"
  String get openAccountBankLabel => "Open Account Bank";
  /// "Payment Account"
  String get paymentAccountLabel => "Payment Account";
  /// "Collection Account"
  String get collectionAccountLabel => "Collection Account";
  /// "QR code"
  String get qrCodeLabel => "QR code";
  /// "Seller Collection Method"
  String get sellerCollectionMethod => "Seller Collection Method";
  /// "Seller Address"
  String get sellerAddress => "Seller Address";
  /// "Buyer Address"
  String get buyerAddress => "Buyer Address";
  /// "Description(200 words)"
  String get description200Words => "Description(200 words)";
  /// "Please describe your question"
  String get pleaseDescription => "Please describe your question";
  /// "ShareCapture"
  String get shareCapture => "ShareCapture";
  /// "(No more than three pictures within 2M of a single picture)"
  String get singlePicture2M => "(No more than three pictures within 2M of a single picture)";
  /// "Submit"
  String get submit => "Submit";
  /// "Vote"
  String get vote => "Vote";
  /// "Repeal"
  String get repeal => "Repeal";
  /// "Reapply"
  String get reapply => "Reapply";
  /// "The appeal has been processed. According to the notarization, we agree to release the COINS. Please note that check"
  String get theAppealHasBeenProcessedAgree => "The appeal has been processed. According to the notarization, we agree to release the COINS. Please note that check";
  /// "Waiting process"
  String get waitingProcess => "Waiting process";
  /// "The appeal has been processed. According to the notarization, we disagree to release the COINS."
  String get theAppealHasBeenProcessedDisAgree => "The appeal has been processed. According to the notarization, we disagree to release the COINS.";
  /// "Just Notice"
  String get justNotice => "Just Notice";
  /// "Detail Appeal"
  String get DetailAppeal => "Detail Appeal";
  /// "Sale"
  String get sell => "Sale";
  /// "Receiving QR Code"
  String get receivingQRCode => "Receiving QR Code";
  /// "Transfer Accounts"
  String get transferAccounts => "Transfer Accounts";
  /// "All Record"
  String get allRecord => "All Record";
  /// "Receive Recorder"
  String get receiveRecorder => "Receive Recorder";
  /// "Transfer Recorder"
  String get transferRecorder => "Transfer Recorder";
  /// "Send Address"
  String get sendAddress => "Send Address";
  /// "Recieve Address"
  String get recieveAddress => "Recieve Address";
  /// "Wallet Setting"
  String get walletSetting => "Wallet Setting";
  /// "Change Wallet Name"
  String get changeWalletName => "Change Wallet Name";
  /// "Backup Wallet Mnemonic Word"
  String get backupWalletMnemonicWord => "Backup Wallet Mnemonic Word";
  /// "Export Private Key"
  String get exportPrivateKey => "Export Private Key";
  /// "Delete Wallet"
  String get deleteWallet => "Delete Wallet";
  /// "Level Description"
  String get levelDescription => "Level Description";
  /// "Write down the 12 mnemonic words in the following order"
  String get WriteDownThe12Mnemonic => "Write down the 12 mnemonic words in the following order";
  /// "Wallet Address"
  String get WalletAddress => "Wallet Address";
  /// "* Please keep it safe and don't let it out to others"
  String get PleaseKeepItSafe => "* Please keep it safe and don't let it out to others";
  /// "Next"
  String get next => "Next";
  /// "Done"
  String get done => "Done";
  /// "Revoke"
  String get revoke => "Revoke";
  /// "Choose the mnemonic from the scrambled mnemonic below and fill in the upper box"
  String get ChooseTheMnemonicFromTheScrambledMnemonic => "Choose the mnemonic from the scrambled mnemonic below and fill in the upper box";
  /// "Create Wallet"
  String get createWallet => "Create Wallet";
  /// "Import Wallet"
  String get importWallet => "Import Wallet";
  /// "Please wait while the wallet is created..."
  String get pleaseWaitWhileTheWalletIsCreated => "Please wait while the wallet is created...";
  /// "Please wait while the wallet is Imported..."
  String get pleaseWaitWhileTheWalletIsImported => "Please wait while the wallet is Imported...";
  /// "Crate wallet success"
  String get createWalletSuccess => "Crate wallet success";
  /// "Mnemonic Word"
  String get mnemonicWord => "Mnemonic Word";
  /// "Private Key"
  String get privateKey => "Private Key";
  /// "Please enter your private key:"
  String get pleaseEnterYourPrivateKey => "Please enter your private key:";
  /// "Import success"
  String get importSuccess => "Import success";
  /// "Please copy carefully and keep it properly. Do not divulge the private key"
  String get pleaseCopyCarefullyAndKeepItProperlyDoNotDivulgeThePrivateKey => "Please copy carefully and keep it properly. Do not divulge the private key";
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_zh_CN extends I18n {
  const _I18n_zh_CN();

  /// "TLD钱包"
  @override
  String get commonPageTitle => "TLD钱包";
  /// "温馨提示：\n      钱包创建在手机端本地。创建钱包会要求您输入钱包密码，钱包会生成您用来恢复钱包的助记词，签名用的私钥，加密和验签用的公钥，以及钱包地址。\n      请妥善保管好您的助记词和私钥"
  @override
  String get homePageNotice => "温馨提示：\n      钱包创建在手机端本地。创建钱包会要求您输入钱包密码，钱包会生成您用来恢复钱包的助记词，签名用的私钥，加密和验签用的公钥，以及钱包地址。\n      请妥善保管好您的助记词和私钥";
  /// "创建钱包"
  @override
  String get createWalletBtnTitle => "创建钱包";
  /// "导入钱包"
  @override
  String get importWalletBtnTitle => "导入钱包";
  /// "您还没有钱包"
  @override
  String get noWalletHint => "您还没有钱包";
  /// "购买"
  @override
  String get buyBtnTitle => "购买";
  /// "查询"
  @override
  String get searchBtnTitle => "查询";
  /// "总量"
  @override
  String get totalAmountLabel => "总量";
  /// "剩余"
  @override
  String get remainAmountLabel => "剩余";
  /// "支付方式"
  @override
  String get paymentTermLabel => "支付方式";
  /// "请输入TLD数量"
  @override
  String get buySearchFieldPlaceholder => "请输入TLD数量";
  /// "地址"
  @override
  String get addressLabel => "地址";
  /// "通知"
  @override
  String get noticeTabLabel => "通知";
  /// "系统消息"
  @override
  String get systemMessageTabLabel => "系统消息";
  /// "消息"
  @override
  String get messageTitle => "消息";
  /// "挂售中"
  @override
  String get onSaleTabTitle => "挂售中";
  /// "待释放"
  @override
  String get waitReleaseTabTitle => "待释放";
  /// "确认释放TLD成功"
  @override
  String get sureReleaseTLDSuccessMessage => "确认释放TLD成功";
  /// "暂无订单"
  @override
  String get noOrderLabel => "暂无订单";
  /// "取消挂售"
  @override
  String get cancelSaleBtnTitle => "取消挂售";
  /// "订单号"
  @override
  String get orderNumLabel => "订单号";
  /// "挂售钱包"
  @override
  String get saleWalletLabel => "挂售钱包";
  /// "创建时间"
  @override
  String get createTimeLabel => "创建时间";
  /// "状态"
  @override
  String get statusLabel => "状态";
  /// "挂售中"
  @override
  String get onSaleStatusLabel => "挂售中";
  /// "已完成"
  @override
  String get finishedStatusLabel => "已完成";
  /// "已取消"
  @override
  String get canceledStatusLabel => "已取消";
  /// "手续费率"
  @override
  String get serviceChargeRateLabel => "手续费率";
  /// "手续费"
  @override
  String get serviceChargeLabel => "手续费";
  /// "预计到账"
  @override
  String get anticipatedToAccount => "预计到账";
  /// "发现"
  @override
  String get findPageTitle => "发现";
  /// "TLD票据"
  @override
  String get tldBillLabel => "TLD票据";
  /// "任务"
  @override
  String get missionLabel => "任务";
  /// "玩法"
  @override
  String get playingMethodLabel => "玩法";
  /// "其他"
  @override
  String get otherLabel => "其他";
  /// "排行榜"
  @override
  String get rankLabel => "排行榜";
  /// "任务待开发中，敬请期待"
  @override
  String get missionNotOpenAlertDesc => "任务待开发中，敬请期待";
  /// "已有相同应用"
  @override
  String get haveSameApplicationAlertDesc => "已有相同应用";
  /// "添加第三方应用成功"
  @override
  String get jointhirdPartyApplictionAlertDesc => "添加第三方应用成功";
  /// "实际付款"
  @override
  String get realPaymentLabel => "实际付款";
  /// "请输入购买的数量"
  @override
  String get inputBuyAmountFieldPlaceholder => "请输入购买的数量";
  /// "全部购买"
  @override
  String get buyAllBtnTitle => "全部购买";
  /// "接收地址"
  @override
  String get receiveAddressLabel => "接收地址";
  /// "请选择接收钱包"
  @override
  String get chooseWalletLabel => "请选择接收钱包";
  /// "下单"
  @override
  String get placeOrderBtnTitle => "下单";
  /// "数量"
  @override
  String get countLabel => "数量";
  /// "应付款"
  @override
  String get shouldPayAmountLabel => "应付款";
  /// "联系卖家"
  @override
  String get contactSellerLabel => "联系卖家";
  /// "联系买家"
  @override
  String get contactBuyerLabel => "联系买家";
  /// "取消订单"
  @override
  String get cancelOrderBtnTitle => "取消订单";
  /// "我已付款"
  @override
  String get surePaymentBtnTitle => "我已付款";
  /// "确认释放TLD"
  @override
  String get sureReleaseTLDBtnTitle => "确认释放TLD";
  /// "催单"
  @override
  String get reminderBtnTitle => "催单";
  /// "订单详情"
  @override
  String get detailOrderPageTitle => "订单详情";
  /// "订单申诉"
  @override
  String get appealOrderLabel => "订单申诉";
  /// "订单申诉中"
  @override
  String get orderIsAppealingLabel => "订单申诉中";
  /// "订单申诉成功"
  @override
  String get appealOrderSuccessLabel => "订单申诉成功";
  /// "订单申诉失败"
  @override
  String get appealOrderFailureLabel => "订单申诉失败";
  /// "取消提现"
  @override
  String get cancelWithdrawLabel => "取消提现";
  /// "待支付"
  @override
  String get waitPayLabel => "待支付";
  /// "已支付"
  @override
  String get havePaidLabel => "已支付";
  /// "已超时"
  @override
  String get overtimeLabel => "已超时";
  /// "申诉中"
  @override
  String get appealingLabel => "申诉中";
  /// "请于"
  @override
  String get pleasePayUntilLabel => "请于";
  /// "分"
  @override
  String get payOrderMinuteLabel => "分";
  /// "秒内支付。"
  @override
  String get payOrderSecondLabel => "秒内支付。";
  /// "等待买家付款"
  @override
  String get waitBuyerPaymentLabel => "等待买家付款";
  /// "等待卖家确认"
  @override
  String get waitSellerSureLabel => "等待卖家确认";
  /// "订单已取消"
  @override
  String get orderHaveCanceledLabel => "订单已取消";
  /// "买入"
  @override
  String get buyingTabTitle => "买入";
  /// "卖出"
  @override
  String get saleTabTitle => "卖出";
  /// "详情"
  @override
  String get detailButtonTitle => "详情";
  /// "订单列表"
  @override
  String get orderListPageTitle => "订单列表";
  /// "金额"
  @override
  String get orderListAmountLabel => "金额";
  /// "释放TLD"
  @override
  String get releaseTLDBtnTitle => "释放TLD";
  /// "重置"
  @override
  String get resetBtnTitle => "重置";
  /// "确认"
  @override
  String get sureBtnTitle => "确认";
  /// "真实姓名"
  @override
  String get realNameLabel => "真实姓名";
  /// "银行卡号"
  @override
  String get bankCardNumLabel => "银行卡号";
  /// "开户行"
  @override
  String get openAccountBankLabel => "开户行";
  /// "支付账号"
  @override
  String get paymentAccountLabel => "支付账号";
  /// "收款账号"
  @override
  String get collectionAccountLabel => "收款账号";
  /// "二维码"
  @override
  String get qrCodeLabel => "二维码";
  /// "卖家收款方式"
  @override
  String get sellerCollectionMethod => "卖家收款方式";
  /// "卖家地址"
  @override
  String get sellerAddress => "卖家地址";
  /// "买家地址"
  @override
  String get buyerAddress => "买家地址";
  /// "描述（200字以内）"
  @override
  String get description200Words => "描述（200字以内）";
  /// "请描述您的申诉问题"
  @override
  String get pleaseDescription => "请描述您的申诉问题";
  /// "截图上传"
  @override
  String get shareCapture => "截图上传";
  /// "（单个图片2M以内,最多三张图片）"
  @override
  String get singlePicture2M => "（单个图片2M以内,最多三张图片）";
  /// "提交"
  @override
  String get submit => "提交";
  /// "投票"
  @override
  String get vote => "投票";
  /// "重新申请"
  @override
  String get reapply => "重新申请";
  /// "申诉已处理，根据公证投票，同意放币，请留意查收。"
  @override
  String get theAppealHasBeenProcessedAgree => "申诉已处理，根据公证投票，同意放币，请留意查收。";
  /// "等待处理"
  @override
  String get waitingProcess => "等待处理";
  /// "申诉已处理，根据公证投票，不同意放币。"
  @override
  String get theAppealHasBeenProcessedDisAgree => "申诉已处理，根据公证投票，不同意放币。";
  /// "公正通知"
  @override
  String get justNotice => "公正通知";
  /// "申诉详情"
  @override
  String get DetailAppeal => "申诉详情";
  /// "出售"
  @override
  String get sell => "出售";
  /// "收款码"
  @override
  String get receivingQRCode => "收款码";
  /// "转账"
  @override
  String get transferAccounts => "转账";
  /// "全部记录"
  @override
  String get allRecord => "全部记录";
  /// "收款记录"
  @override
  String get receiveRecorder => "收款记录";
  /// "转账记录"
  @override
  String get transferRecorder => "转账记录";
  /// "发送地址"
  @override
  String get sendAddress => "发送地址";
  /// "接收地址"
  @override
  String get recieveAddress => "接收地址";
  /// "钱包设置"
  @override
  String get walletSetting => "钱包设置";
  /// "更改钱包名称"
  @override
  String get changeWalletName => "更改钱包名称";
  /// "备份助记词"
  @override
  String get backupWalletMnemonicWord => "备份助记词";
  /// "导出私钥"
  @override
  String get exportPrivateKey => "导出私钥";
  /// "删除钱包"
  @override
  String get deleteWallet => "删除钱包";
  /// "等级说明"
  @override
  String get levelDescription => "等级说明";
  /// "按照下面的顺序抄下12个助记词"
  @override
  String get WriteDownThe12Mnemonic => "按照下面的顺序抄下12个助记词";
  /// "钱包地址"
  @override
  String get WalletAddress => "钱包地址";
  /// "*请妥善保管，不要泄露给他人。"
  @override
  String get PleaseKeepItSafe => "*请妥善保管，不要泄露给他人。";
  /// "下一步"
  @override
  String get next => "下一步";
  /// "完成"
  @override
  String get done => "完成";
  /// "撤回"
  @override
  String get revoke => "撤回";
  /// "从下面打乱的助记词中选择助记词填到上面的格子中"
  @override
  String get ChooseTheMnemonicFromTheScrambledMnemonic => "从下面打乱的助记词中选择助记词填到上面的格子中";
  /// "创建钱包"
  @override
  String get createWallet => "创建钱包";
  /// "导入钱包"
  @override
  String get importWallet => "导入钱包";
  /// "钱包创建中，请您耐心等待……"
  @override
  String get pleaseWaitWhileTheWalletIsCreated => "钱包创建中，请您耐心等待……";
  /// "钱包导入中，请您耐心等待……"
  @override
  String get pleaseWaitWhileTheWalletIsImported => "钱包导入中，请您耐心等待……";
  /// "创建钱包成功"
  @override
  String get createWalletSuccess => "创建钱包成功";
  /// "助记词"
  @override
  String get mnemonicWord => "助记词";
  /// "私钥"
  @override
  String get privateKey => "私钥";
  /// "请在下面输入您的私钥："
  @override
  String get pleaseEnterYourPrivateKey => "请在下面输入您的私钥：";
  /// "导入成功"
  @override
  String get importSuccess => "导入成功";
  /// "请认真抄写,妥善保管,切勿泄漏私钥"
  @override
  String get pleaseCopyCarefullyAndKeepItProperlyDoNotDivulgeThePrivateKey => "请认真抄写,妥善保管,切勿泄漏私钥";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", "US"),
      Locale("zh", "CN")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("zh_CN" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("zh" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}