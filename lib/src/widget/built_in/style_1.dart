import 'package:awesome_toast/awesome_toast.dart';
import 'package:awesome_toast/src/core/extentions/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../toast_envelope.dart';

//Juste des test tout est à revoir
class Style1 extends StatelessWidget {
  final AwesomeToastType type;
  final AwesomeToastStyle style;
  final String? description;
  const Style1({
    super.key,
    required this.type,
    this.style = AwesomeToastStyle.style1,
    required this.description,
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
              color: style == AwesomeToastStyle.style1 ||
                      style == AwesomeToastStyle.style3
                  ? type.color.primary
                  : Colors.white,
            ),
            5.horisontalSpace,
            Text(
              overflow: TextOverflow.ellipsis,
              type.message,
              style: TextStyle(
                  color: style == AwesomeToastStyle.style1 ||
                          style == AwesomeToastStyle.style3
                      ? black
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            GestureDetector(
              //onTap: onCloce,
              child: Icon(
                weight: 0.2,
                size: 24,
                Icons.close,
                color: style == AwesomeToastStyle.style1 ||
                        style == AwesomeToastStyle.style3
                    ? type.color.primary
                    : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
