import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/ui_parameters.dart';

import '../../constants/colors.dart';
import 'answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard({Key? key,
    required this.index,
    required this.status,
    required this.onTap
  }) : super(key: key);

  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    bool isDark = Brightness.dark == brightness;
    Color _backgroundColor = Theme.of(context).primaryColor;
    switch(status){
      case AnswerStatus.answered:
        _backgroundColor: isDark?
            Theme.of(context).cardColor:Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        _backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        _backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notanswered:
        _backgroundColor = isDark ? Colors.red.withOpacity(0.5) :
          Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      default:
        _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(28)
        ),
        child: Center(
          child: Text('$index',
          style: TextStyle(
            color: status== AnswerStatus.notanswered?Theme.of(context).primaryColor:
                null
          ),
          ),
        ),
      ),
    );
  }
}
