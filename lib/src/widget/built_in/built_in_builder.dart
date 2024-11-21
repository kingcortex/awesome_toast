import 'package:awesome_toast/src/widget/built_in/style_1.dart';
import 'package:awesome_toast/src/widget/built_in/style_2.dart';
import 'package:flutter/material.dart';

import '../../../awesome_toast.dart';

/// [BuiltInBuilder] est la classe qui permet de build tout les toast préconçu

class BuiltInBuilder extends StatelessWidget {
  final Widget title;
  final Widget? description;
  final AwesomeToastStyle? style;
  final AwesomeToastType type = AwesomeToastType.info;
  const BuiltInBuilder(
      {super.key,
      this.style = AwesomeToastStyle.style1,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    final AwesomeToastStyle style = this.style ?? AwesomeToastStyle.style1;
    return switch (style) {
      AwesomeToastStyle.style1 => Style1(
          type: type,
          description: description,
          title: title,
        ),
      AwesomeToastStyle.style2 => Style2(
          type: type,
          description: description,
          title: title,
        )
    };
  }
}
