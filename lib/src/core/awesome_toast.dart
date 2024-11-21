import 'package:awesome_toast/src/core/awesome_toast_provider.dart';
import 'package:awesome_toast/src/core/extentions/context_ext.dart';
import 'package:awesome_toast/src/core/type.dart';
import 'package:flutter/material.dart';

class AwesomeToast {
  static final AwesomeToast _instance = AwesomeToast._internal();

  /// Private constructor for the singleton class
  AwesomeToast._internal();

  /// returns the singleton instance of the class
  factory AwesomeToast() => _instance;

  void show({
    required BuildContext context,
    required Widget title,
    Widget? description,
    AwesomeToastType type = AwesomeToastType.info,
    Duration? autoCloseDuration,
  }) {
    context.toastState.show(
      context: context,
      title: Text("hello"),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
