import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/constants/image_string.dart';
import 'package:uniquiz/src/constants/text_strings.dart';
import 'package:uniquiz/src/controllers/auth_controller.dart';

class IntroductionScreen extends GetView<AuthController> {
  const IntroductionScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration:  BoxDecoration(gradient: mainGradient()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(tIntroductionScreen),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  Text(tWelcomeTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2),
                  const SizedBox(height: 20),
                  Text(tWelcomeBody, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6)
                  ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.signInWithGoogle();
                },
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 15,
                      bottom: 0,
                      child: SvgPicture.asset(tGoogleLogo)
                    ),
                    Center(
                      child: Text(
                        tSignInWithGoogle,
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.black87 : Colors.white70,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
