import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
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
    return Material(
      borderRadius: addRadiusBottom ? const BorderRadius.all(Radius.circular(20)) : const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffoldColor(),
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
