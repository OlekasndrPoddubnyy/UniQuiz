import 'package:flutter/material.dart';
import 'package:uniquiz/src/constants/app_icons.dart';
import 'package:uniquiz/src/constants/ui_parameters.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/screens/question/quiz_overview_screen.dart';
import '../../constants/custom_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key,
    this.title ='',
    this.showActionIcon=false,
    this.titleWidget,
    this.leading,
    this.onMenuActionTap
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mobileScreenPadding,
              vertical: mobileScreenPadding
            ),
            child: Stack(
              children: [
                Positioned.fill(
                    child: titleWidget==null?Center(
                      child: Text(title, style: appBarTs,),
                    ):Center(
                      child: titleWidget,
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    leading??Transform.translate(offset: const Offset(-10, -5),
                    child: const BackButton(color: Colors.white,),
                    ),
                    if(showActionIcon)
                      Transform.translate(offset: const Offset(10, 0),
                      child: IconButton(
                        onPressed: onMenuActionTap??() => Get.toNamed(QuizOverviewScreen.routeName),
                        icon: const Icon(AppIcons.menu, color: Colors.white, size: 18,),

                      ),
                      )
                  ],
                )
              ],
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
