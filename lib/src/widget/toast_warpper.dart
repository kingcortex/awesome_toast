import 'package:awesome_toast/src/core/awesome_toast_item.dart';
import 'package:awesome_toast/src/widget/built_in/built_in_builder.dart';
import 'package:flutter/material.dart';

import '../core/awesome_toast_provider.dart';
import '../core/style/styles.dart';
import '../core/type.dart';
import 'glass.dart';
import 'toast_envelope.dart';



/// On peut accéder à l'état de cette classe grâce à [AwesomeToastProvider].
///
/// Cette classe nécessite encore beaucoup de travail et de corrections de bugs.
/// Il faut également trouver un autre moyen d'afficher les toasts déroulés et de les grouper.
/// Actuellement, j'ai simplement rendu le système général fonctionnel.


class AwesomeToastWrapper extends StatefulWidget {
  final Widget child;
  const AwesomeToastWrapper(
      {super.key, required this.child});

  @override
  AwesomeToastWrapperState createState() => AwesomeToastWrapperState();
}

class AwesomeToastWrapperState extends State<AwesomeToastWrapper> {
  bool isExpended = false;
  final List<AwesomeToastItem> _toasts = [];
  final List<GlobalKey<AwesomeToastEnvelopeState>> _toastKeys = [];
  @override
  void initState() {
    super.initState();
  }

  /// On change le [isExpended] à true ce qui permet d'afficher la [GlassmorphismContainer]
  /// Et on stop les timer present dans chaque [AwesomeToastItem]
  void expanded() {
    setState(() {
      isExpended = true;
    });

    for (var item in _toasts) {
      item.stopTimer();
    }
  }

  void fold() {
    setState(() {
      isExpended = false;
    });
    for (var item in _toasts) {
      item.startTimer();
    }
  }

  void show({
    required BuildContext context,
    required Widget title,
    Widget? description,
    AwesomeToastStyle? style,
    AwesomeToastType type = AwesomeToastType.info,
    Duration? autoCloseDuration,
  }) {
    AwesomeToastItem item = AwesomeToastItem(
      autoCloseDuration: autoCloseDuration,
      builder: BuiltInBuilder(
        style: style,
        title: title,
        description: description,
      ),
      onAutoClose: _deleteToast,
    );
    setState(() {
      _toasts.add(item);
      _toastKeys.add(GlobalKey<AwesomeToastEnvelopeState>());
    });
  }

  void _deleteToast(AwesomeToastItem item) {
    setState(() {
      _toasts.removeWhere((v) => item.id == v.id);
      //_toastKeys.remove(index);
    });
    if (_toasts.isEmpty) {
      isExpended = false;
    }
    print(_toasts.length);
  }

  double getGap(int index) {
    int maxLenght = _toasts.length;
    print(maxLenght);

    if (maxLenght <= 3) {
      print("index $index => ${50 - index * 6}");
      return 50 - index * 6;
    }
    if (index == 0) {
      print("index $index => ${50 + 1 * 12}");
      return 50 + 1 * 12;
    }
    if (index == 1) {
      print("index $index => ${50 + 0.5 * 12}");
      return 50 + 0.5 * 12;
    }

    print("index $index => ${50}");
    return 50;
  }

  double getScale(int index) {
    int maxLenght = _toasts.length;
    if (maxLenght <= 3) {
      if (index == 0) {
        if (maxLenght == 1) return 1;
        if (maxLenght == 2) {
          return 0.92;
        }
        return 0.84;
      }
      if (index == 1) {
        if (maxLenght <= 2) return 1;
        return 0.92;
      }
    }

    if (index == 0) {
      return 0.84;
    }

    if (index == 1) {
      return 0.92;
    }

    return 1;
  }


  

  @override
  Widget build(BuildContext context) {
    return AwesomeToastProvider(
      state: this,
      child: SizedBox(
        //width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            widget.child,
            if (isExpended) GlassmorphismContainer(ontap: () => fold()),
            ..._toasts.asMap().entries.map((entry) {
              int index = entry.key;
              AwesomeToastItem item = entry.value;
              return AnimatedPositioned(
                curve: isExpended ? Curves.easeOutBack : Curves.easeOut,
                bottom: isExpended
                    ? 50 + (_toasts.length - index) * 65
                    : getGap(index), // Décalage pour chaque toast
                left: 20,
                right: 20,
                duration: isExpended
                    ? const Duration(milliseconds: 400)
                    : const Duration(milliseconds: 200),
                child: Transform.scale(
                  scaleX: isExpended ? 1 : getScale(index),
                  child: item.toast,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
