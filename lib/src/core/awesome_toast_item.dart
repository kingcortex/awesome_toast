import 'dart:async';

import 'package:awesome_toast/src/widget/toast_envelope.dart';
import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';

class AwesomeToastItem {
  final Widget builder;
  final Duration? autoCloseDuration;
  final void Function(AwesomeToastItem item)? onAutoClose;
  AwesomeToastItem({
    required this.builder,
    this.autoCloseDuration,
    required this.onAutoClose,
  }) : id = UniqueKey().toString() {
    print(autoCloseDuration);
    if (autoCloseDuration != null) {
      _timer = PausableTimer(
        autoCloseDuration!,
        () => onAutoClose?.call(this),
      );
      startTimer();
    }
  }

  Widget get widget => AwesomeToastEnvelope(item: this);

  late PausableTimer _timer;
  final String id;

  void startTimer() {
    _timer.start();
  }

  void stopTimer() {
    _timer.pause();
  }
}
