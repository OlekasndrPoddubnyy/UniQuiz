import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/colors.dart';
import '../constants/ui_parameters.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({Key? key,
    required this.child,
    this.addPadding = true,
    this.addRadiusBottom = false,
  }) : super(key: key);
  final bool addPadding;
  final bool addRadiusBottom;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    bool isDark = Brightness.dark == brightness;
    return Material(
      borderRadius: addRadiusBottom ? const BorderRadius.all(Radius.circular(20)) : const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Ink(
        decoration: BoxDecoration(
          color: isDark ? primaryColorDark.withOpacity(0.4)
              :const Color.fromARGB(255, 240, 237, 255),
        ),
        padding: addPadding ? EdgeInsets.only(
          top: mobileScreenPadding,
          left: mobileScreenPadding,
          right: mobileScreenPadding,
        ) : EdgeInsets.zero,
        child: child,

      ),
    );
  }
}
