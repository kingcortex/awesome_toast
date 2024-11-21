import 'package:awesome_toast/src/core/type.dart';
import 'package:flutter/material.dart';

const Color infoPrimary = Color(0xff4B85F5);
const Color errorPrimary = Color(0xffF04349);
const Color warningPrimary = Color(0xffFDCD0F);
const Color successPrimary = Color(0xff01E17B);
const Color black = Color(0xff28292A);

const Color infoSecondary = Color(0xffEDF2FD);
const Color errorSecondary = Color(0xffFDECEC);
const Color warningSecondary = Color(0xffFFFAE8);
const Color successSecondary = Color(0xffE5FCF1);
const Color blackSecondary = Color(0xff28292A);

class ToastColors {
  final Color primary;
  final Color secondary;

  ToastColors({required this.primary, required this.secondary});
}

extension AwesomeToastTypeColor on AwesomeToastType {
  ToastColors get color {
    switch (this) {
      case AwesomeToastType.info:
        return ToastColors(primary: infoPrimary, secondary: infoSecondary);
      case AwesomeToastType.error:
        return ToastColors(primary: errorPrimary, secondary: errorSecondary);
      case AwesomeToastType.warning:
        return ToastColors(
            primary: warningPrimary, secondary: warningSecondary);
      case AwesomeToastType.success:
        return ToastColors(
            primary: successPrimary, secondary: successSecondary);
    }
  }
}

extension AwesomeToastTypeMessage on AwesomeToastType {
  String get message {
    switch (this) {
      case AwesomeToastType.info:
        return "This is an informational message.";
      case AwesomeToastType.error:
        return "An error has occurred.";
      case AwesomeToastType.warning:
        return "This is warning message.";
      case AwesomeToastType.success:
        return "This success message.";
    }
  }
}

enum AwesomeToastStyle {
  style1,
  style2,
}

extension AwesomeToastStyleExtention on AwesomeToastStyle {
  BoxDecoration decoration(ToastColors toastColors) {
    switch (this) {
      case AwesomeToastStyle.style1:
        return BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff030512).withOpacity(0.1),
              spreadRadius: -8,
              blurRadius: 20,
              offset: const Offset(0, 16),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          //border: Border.all()
        );
      case AwesomeToastStyle.style2:
        return BoxDecoration(
          color: toastColors.primary,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff030512).withOpacity(0.1),
              spreadRadius: -8,
              blurRadius: 20,
              offset: const Offset(0, 16),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          //border: Border.all()
        );
      // case AwesomeToastStyle.style3:
      //   return BoxDecoration(
      //     color: toastColors.secondary,
      //     boxShadow: [
      //       BoxShadow(
      //         color: const Color(0xff030512).withOpacity(0.1),
      //         spreadRadius: -8,
      //         blurRadius: 20,
      //         offset: const Offset(0, 16),
      //       ),
      //     ],
      //     borderRadius: BorderRadius.circular(20),
      //     border: Border.all(color: toastColors.primary),
      //   );
      default:
        return const BoxDecoration();
    }
  }
}
