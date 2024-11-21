import 'package:flutter/material.dart';

import '../../awesome_toast.dart';

class AwesomeToastProvider extends InheritedWidget {
  final  AwesomeToastWrapperState state;

  const AwesomeToastProvider({
    required this.state,
    super.key,
    required super.child,
  });

  static AwesomeToastProvider? of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AwesomeToastProvider>();
    print("AwesomeToastProvider trouvé: ${provider != null}");
    assert(provider != null, "Envelopper vôtre application");
    return provider;
  }

  @override
  bool updateShouldNotify(AwesomeToastProvider oldWidget) => false;
}
