import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';

import '../../constants/colors.dart';

class BackgroundDecoration extends GetView<QuestionsController> {
  final Widget child;
  final bool showGradient;
  const BackgroundDecoration({Key? key,
    required this.child,
    this.showGradient = false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: showGradient ? null : Get.isDarkMode ? trophyColor : const Color(0xead21d3d),
                gradient: showGradient ? mainGradient() : null,
              ),
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            )
        ),
        Positioned(child: SafeArea(child: child))
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width*0.65, 0);
    path.lineTo(size.width*0.2, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}
