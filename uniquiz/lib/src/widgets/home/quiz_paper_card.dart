
import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_icons.dart';
import '../../constants/colors.dart';
import '../../constants/custom_text_styles.dart';
import '../../constants/ui_parameters.dart';
import '../../controllers/question_paper/quiz_papers_controller.dart';
import '../../models/question_paper_model.dart';
import '../common/icon_with_text.dart';

class QuizPaperCard extends GetView<QuizPaperController> {
  const QuizPaperCard({Key? key, required this.model}) : super(key: key);

  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Get.isDarkMode ? primaryColorDarkCard
            : cardColor,
      ),
      child: InkWell(
        borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          controller.navigatoQuestions(
              paper: model
          );
        },
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: UIParameters.cardBorderRadius,
                      child: ColoredBox(
                          color: Get.isDarkMode ?
                          tPrimaryColor.withOpacity(0.2)
                              :primaryColorLigth.withOpacity(0.1),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: model.imageUrl == null ||  model.imageUrl!.isEmpty ? null : Image.network(model.imageUrl!),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title,
                              style: cartTitles(context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 15),
                              child: Text(model.description),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: EasySeparatedRow(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(width: 15);
                                },
                                children: [
                                  IconWithText(
                                      icon: Icon(Icons.help_outline_sharp,
                                          color: Colors.blue[500]),
                                      text: Text(
                                        '${model.questionCount} quizzes',
                                        style: questionTS.copyWith(
                                            color: Colors.blue[700]),
                                      )),
                                  IconWithText(
                                      icon: Icon(Icons.timer,
                                          color: Colors.blue[200]),
                                      text: Text(
                                        model.timeInMinits(),
                                        style: questionTS.copyWith(
                                            color: Colors.blueGrey),
                                      )),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                      behavior : HitTestBehavior.translucent,
                      onTap: () {
                        //Get.toNamed(LeaderBoardScreen.routeName, arguments:model );
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight:
                                Radius.circular(20)),
                            color: Get.isDarkMode ? tOnBoardingPage2Color.withOpacity(0.25)  : Theme.of(context).primaryColor.withOpacity(0.25)),
                        child: const Icon(AppIcons.trophyOutLine),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
