import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/custom_text_styles.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';
import 'package:uniquiz/src/widgets/common/background_color.dart';
import 'package:uniquiz/src/widgets/common/custom_app_bar.dart';
import 'package:uniquiz/src/widgets/content_area.dart';
import 'package:uniquiz/src/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({Key? key}) : super(key: key);

  static const String routeName = "/answercheckscreen";

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    bool isDark = Brightness.dark == brightness;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() =>
          Text('Q. ${(controller.questionIndex.value+1).toString().padLeft(2,"0")}.',
            style: appBarTs,
          )
        ),
      ),
      body: Obx(() => BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Text(controller.currentQuestion.value!.question!,
                          style: questionTS),
                        const SizedBox(height: 20),
                        GetBuilder<QuestionsController>(
                            id: 'answers_review_list',
                            builder: (_){
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index){
                                    final answer = controller.currentQuestion.value!.answers![index];
                                    final selectedAnswer =
                                        controller.currentQuestion.value!.selectedAnswer;
                                    final correctAnswer =
                                        controller.currentQuestion.value!.correctAnswer;
                                    final String answerText =
                                        '${answer.identifier}.  ${answer.answer}';
                                    if(correctAnswer == selectedAnswer &&
                                    answer.identifier == selectedAnswer){
                                      return CorrectAnswer(answer: answerText);
                                    }else if(correctAnswer != selectedAnswer &&
                                    answer.identifier == selectedAnswer){
                                      return WrongAnswer(answer: answerText);
                                    }else if (correctAnswer == answer.identifier){
                                      return CorrectAnswer(answer: answerText);
                                    }
                                    return AnswerCard(
                                        answer: answerText,
                                        onTap: (){},
                                        isSelected: false
                                    );
                                  },
                                  separatorBuilder: (_, index){
                                    return const SizedBox(height: 10);
                                  },
                                  itemCount: controller.currentQuestion.value!.answers!.length
                              );
                        })
                      ],
                    ),
                  ),
                )
            )
          ],
        )),
      ),
    );
  }
}
