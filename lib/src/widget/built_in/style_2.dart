import 'package:awesome_toast/awesome_toast.dart';
import 'package:awesome_toast/src/core/extentions/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'built_in_content.dart';

//Juste des test tout est à revoir

class Style2 extends StatelessWidget {
  final AwesomeToastType type;
  final AwesomeToastStyle style;
  final Widget title;
  final Widget? description;
  const Style2({
    super.key,
    required this.type,
    this.style = AwesomeToastStyle.style2,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: style.decoration(type.color),
      child: Center(
        child: Row(
          children: [
            SvgPicture.asset(
                package: "awesome_toast",
                type == AwesomeToastType.success
                    ? "assets/icons/svg/sucess_.svg"
                    : "assets/icons/svg/info.svg",
                color: type.color.primary),
            5.horisontalSpace,
            BuiltInContent(
              title: title,
              description: description,
            ),
            const Spacer(),
            GestureDetector(
              //onTap: onCloce,
              child: Icon(
                  weight: 0.2,
                  size: 24,
                  Icons.close,
                  color: type.color.primary),
            )
          ],
        ),
      ),
    );
  }
}
