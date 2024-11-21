import 'package:awesome_toast/src/core/awesome_toast_provider.dart';
import 'package:flutter/material.dart';

import '../../../awesome_toast.dart';

extension ContextExt on BuildContext {
  AwesomeToastProvider get toastProvider => AwesomeToastProvider.of(this)!;
  AwesomeToastWrapperState get toastState =>
      AwesomeToastProvider.of(this)!.state;
}
