import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Page/tld_acceptance_invitation_qr_code_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDPromotionPage extends StatefulWidget {
  TLDPromotionPage({Key key}) : super(key: key);

  @override
  _TLDPromotionPageState createState() => _TLDPromotionPageState();
}

class _TLDPromotionPageState extends State<TLDPromotionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'promotion_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).promotion,
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: TLDAcceptanceInvitationQRCodePage(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }
}