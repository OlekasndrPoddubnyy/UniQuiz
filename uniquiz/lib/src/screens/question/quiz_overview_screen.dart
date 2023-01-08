import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/ui_parameters.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';
import 'package:uniquiz/src/widgets/common/background_color.dart';
import 'package:uniquiz/src/widgets/common/custom_app_bar.dart';
import 'package:uniquiz/src/widgets/questions/answer_card.dart';
import 'package:uniquiz/src/widgets/questions/countdown_timer.dart';
import 'package:uniquiz/src/widgets/questions/question_number_card.dart';

import '../../widgets/content_area.dart';

class QuizOverviewScreen extends GetView<QuestionsController> {
  const QuizOverviewScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizoverview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:CustomAppBar(
        title: controller.completedQuiz,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Tempo Restante: ",
                                style: TextStyle(
                                  color: UIParameters.isDarkMode() ? Theme.of(context).textTheme.bodyText1!.color
                                      : Theme.of(context).textTheme.bodyText2!.color,
                                  letterSpacing: 1,)
                            ),
                            CountdownTimer(
                              color: UIParameters.isDarkMode() ? Theme.of(context).textTheme.bodyText1!.color
                                  : Color.fromARGB(255, 87, 9, 9).withOpacity(0.8),
                              time: '',
                            ),
                            Obx(() => Text(
                              '${controller.time}',
                              style: TextStyle(
                                color: UIParameters.isDarkMode() ? Theme.of(context).textTheme.bodyText1!.color
                                    : Color.fromARGB(255, 87, 9, 9).withOpacity(0.8),
                                letterSpacing: 2,
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.allQuestions.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Get.width ~/75,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8
                              ),
                              itemBuilder: (_, index){
                                AnswerStatus? _answerStatus;
                                if(controller.allQuestions[index].selectedAnswer!=null){
                                  _answerStatus = AnswerStatus.answered;
                                }
                                return QuestionNumberCard(
                                    index: index+1,
                                    status: _answerStatus,
                                    onTap: () => controller.jumpToQuestion(index)
                                );
                              }
                          ),
                        )
                      ],
                    )
                )
            ),
            ColoredBox(
                color:  Get.isDarkMode ? const Color(0xff232f46)
                    :const Color.fromARGB(255, 240, 237, 255),
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: OutlinedButton(
                    onPressed: () {
                      controller.complete();
                    },
                    child: const Center(
                      child: Text('Complete'),
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
