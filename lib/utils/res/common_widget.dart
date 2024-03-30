

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';


showBotToast(String? message) {
  BotToast.showSimpleNotification(
    title: message ?? "Something went wrong",
    duration: Duration(seconds: 4),
    hideCloseButton: true,
    backgroundColor: Colors.grey,
    titleStyle: const TextStyle(color: Colors.white),
    borderRadius: 8,
  );
}