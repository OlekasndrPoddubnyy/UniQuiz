import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/ui_parameters.dart';

import 'colors.dart';

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorLigth, primaryColorLigth]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryDarkColorDark,
      primaryColorDark,
    ]);

LinearGradient mainGradient() =>
    Get.isDarkMode ? mainGradientDark : mainGradientLight;


Color customScaffoldColor() =>
    Get.isDarkMode ? primaryColorDark.withOpacity(0.4)
        :const Color.fromARGB(255, 240, 237, 255);

Color answerSelectedColor() =>
    UIParameters.isDarkMode() ? const Color.fromARGB(255, 20, 46, 158).withOpacity(0.5)
        :Theme.of(Get.context!).primaryColor.withOpacity(0.5);

Color answerBorderColor() =>
    UIParameters.isDarkMode() ? const Color.fromARGB(255, 20, 46, 158)
        : const Color.fromARGB(255, 221, 221, 221);

Color answerNotSelectedColor() =>
    UIParameters.isDarkMode() ? primaryColorDark.withOpacity(0.5)
        : Theme.of(Get.context!).cardColor;

Color answerNotSelectedBorderColor() =>
    UIParameters.isDarkMode() ? Colors.transparent
        : const Color.fromARGB(255, 221, 221, 221);