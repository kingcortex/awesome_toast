import 'package:awesome_toast/src/core/awesome_toast_item.dart';
import 'package:awesome_toast/src/widget/built_in/style_1.dart';
import 'package:awesome_toast/src/widget/built_in/style_2.dart';
import 'package:flutter/material.dart';

import '../core/awesome_toast_provider.dart';
import '../core/style/styles.dart';
import '../core/type.dart';
import 'glass.dart';
import 'toast_envelope.dart';

class AwesomeToastWrapper extends StatefulWidget {
  final Widget child;
  final AwesomeToastStyle style;
  const AwesomeToastWrapper(
      {super.key, required this.child, this.style = AwesomeToastStyle.style1});

  @override
  AwesomeToastWrapperState createState() => AwesomeToastWrapperState();
}

class AwesomeToastWrapperState extends State<AwesomeToastWrapper> {
  bool isExpended = false;
  final List<AwesomeToastItem> _toasts = [];
  final List<GlobalKey<AwesomeToastEnvelopeState>> _toastKeys = [];

  late AwesomeToastStyle _style;
  @override
  void initState() {
    _style = widget.style;
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

  /// On change le [isExpended] à true ce qui permet d'afficher la [GlassmorphismContainer]
  /// Et on stop les timers present dans chaque [AwesomeToastItem]
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
    AwesomeToastType type = AwesomeToastType.info,
    Duration? autoCloseDuration,
  }) {
    setState(() {
      _toasts.add(AwesomeToastItem(
          autoCloseDuration: autoCloseDuration,
          builder: Style2(
            type: type,
            description: "",
          ),
          onAutoClose: _deleteToast));
      _toastKeys.add(GlobalKey<AwesomeToastEnvelopeState>());
    });

    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     _toasts.removeAt(0); // Supprimer le premier toast après 2 secondes
    //     _toastKeys.removeAt(0); // Supprimer la clé correspondante
    //   });
    // });
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

  void _setStyle(AwesomeToastStyle style) {
    setState(() {
      _style = style;
    });
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
                  child: item.widget,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
