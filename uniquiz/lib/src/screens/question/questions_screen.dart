import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/colors.dart';
import 'package:uniquiz/src/constants/custom_text_styles.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';
import 'package:uniquiz/src/firebase/firebase_ref.dart';
import 'package:uniquiz/src/screens/question/quiz_overview_screen.dart';
import 'package:uniquiz/src/widgets/common/background_color.dart';
import 'package:uniquiz/src/widgets/common/custom_app_bar.dart';
import 'package:uniquiz/src/widgets/common/question_place_holder.dart';
import 'package:uniquiz/src/widgets/questions/answer_card.dart';
import 'package:uniquiz/src/widgets/questions/countdown_timer.dart';

import '../../widgets/content_area.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({Key? key}) : super(key: key);

  static const String routeName = "/questionScreens";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(
                  color: onSurfaceTextColor, width: 2
                )
              )
          ),
          child: Obx(() => CountdownTimer(time: controller.time.value, color: Colors.white,)),
        ),
        showActionIcon: true,
        titleWidget: Obx(() => Text(
            'Q. ${(controller.questionIndex.value+1).toString().padLeft(2, '0')}',
            style:appBarTs),
        )),
      body: BackgroundDecoration(
          child: Obx(() => Column(
            children: [
              if(controller.loadingStatus.value==LoadingStatus.loading)
                const Expanded(
                    child: ContentArea(child: QuestionScreenHolder())
                ),
              if(controller.loadingStatus.value==LoadingStatus.completed)
                Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question!,
                              style: questionTS,
                            ),
                            GetBuilder<QuestionsController>(
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index){
                                        final answer =
                                        controller.currentQuestion.value!.answers![index];
                                        return AnswerCard(
                                          answer: '${answer.identifier}.  ${answer.answer}',
                                          onTap: () {
                                            controller.selectAnswer(answer.identifier);
                                          },
                                          isSelected:
                                          answer.identifier == controller.currentQuestion.value!.selectedAnswer,
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) =>
                                      const SizedBox(height: 10),
                                      itemCount: controller.currentQuestion.value!.answers!.length);
                                })
                          ],
                        ),
                      ),
                    )
                ),
              ColoredBox(
                color: Get.isDarkMode ? const Color(0xff232f46)
                    :const Color.fromARGB(255, 240, 237, 255),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                            child: OutlinedButton(

                              onPressed: () {
                                controller.prevQuestion();
                              },
                              child: Icon(Icons.arrow_back_ios_new,
                                color: Get.isDarkMode ? onSurfaceTextColor : Theme.of(context).primaryColor,
                                size: 18,
                              ),
                            )
                        ),
                      Visibility(
                          visible: controller.isFirstQuestion,
                          child: const SizedBox(width: 20)),
                      Expanded(
                        child: Visibility(
                            visible: controller.loadingStatus.value == LoadingStatus.completed,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.all(18)
                              ),
                              onPressed: () {
                                controller.islastQuestion
                                    ? Get.toNamed(QuizOverviewScreen.routeName)
                                    : controller.nextQuestion();
                              },
                              child: Center(
                                child: Text( controller.islastQuestion ? 'Complete' : 'Next'),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),

            ],
          )
          )
      ),
    );
  }
}
