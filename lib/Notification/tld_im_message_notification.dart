import 'package:flutter/material.dart';

class TLDIMMessageNotification extends Notification {
  TLDIMMessageNotification({@required this.messageList});

  final List messageList;
}