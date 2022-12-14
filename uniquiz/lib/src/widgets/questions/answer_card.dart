import 'package:flutter/material.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/constants/colors.dart';
import 'package:uniquiz/src/constants/ui_parameters.dart';

enum AnswerStatus{
  correct, wrong, answered, notanswered
}

class AnswerCard extends StatelessWidget {
  const AnswerCard({Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap
  }) : super(key: key);

  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: isSelected ? answerSelectedColor() : answerNotSelectedColor(),
          border: Border.all(
            color: isSelected ? answerSelectedColor() : answerNotSelectedBorderColor()
          )
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,

          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({Key? key, required this.answer}) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
        border: Border.all(
          color: correctAnswerColor
        )
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
          color: correctAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({Key? key, required this.answer}) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
          border: Border.all(
              color: wrongAnswerColor
          )
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
          color: wrongAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

