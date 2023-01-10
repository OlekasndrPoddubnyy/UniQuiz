import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/constants/image_string.dart';
import 'package:uniquiz/src/constants/text_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    var darkTheme = Theme.of(context).brightness;
    bool isDark = Brightness.dark == darkTheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: isDark ?  mainGradientDark : mainGradientLight),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(tSplashScreen, height:  Get.height*0.75, width: Get.width*0.8),
            const SizedBox(height:40),
            Text(tAppName, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 56,
              color:Colors.white.withOpacity(0.65)
            ),)
          ],
        ),
      ),
    );
  }
}
