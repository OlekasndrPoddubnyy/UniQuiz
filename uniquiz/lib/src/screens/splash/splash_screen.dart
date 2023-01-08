import 'package:flutter/material.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/constants/image_string.dart';
import 'package:uniquiz/src/constants/text_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(tSplashScreen, height: 600, width: 400),
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
