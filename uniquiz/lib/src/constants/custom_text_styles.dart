import 'package:flutter/material.dart';

import 'colors.dart';
import 'ui_parameters.dart';

TextStyle cartTitles(context) => TextStyle(
  color: UIParameters.isDarkMode()
      ? Theme.of(context).textTheme.bodyText1!.color
      : Theme.of(context).primaryColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const detailText = TextStyle(
  fontSize: 25
);
const headerText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: onSurfaceTextColor
);
const questionTS = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);

const appBarTs = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: onSurfaceTextColor
);