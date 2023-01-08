import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/custom_text_styles.dart';
import 'package:uniquiz/src/constants/image_string.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';
import 'package:uniquiz/src/controllers/question_paper/quiz_result_extention_qc.dart';
import 'package:uniquiz/src/screens/question/check_answer_screen.dart';
import 'package:uniquiz/src/widgets/common/background_color.dart';
import 'package:uniquiz/src/widgets/content_area.dart';
import 'package:uniquiz/src/widgets/questions/answer_card.dart';
import 'package:uniquiz/src/widgets/questions/question_number_card.dart';

import '../../constants/colors.dart';
import '../../constants/ui_parameters.dart';
import '../../widgets/common/custom_app_bar.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);

  static const String routeName = "/resultscreen";

  @override
  Widget build(BuildContext context) {
    Color _textColor = Get.isDarkMode ? tOnBoardingPage3Color : primaryColorLigth;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(height: 80),
        title: controller.correctAnsweredQuestions,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
                  child: Column(
                    children: [
                      Image.asset(tResultScreenImage,height: 200, width: 250,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text('Congratulazioni',
                          style: headerText.copyWith(
                              color: _textColor
                          ),
                        ),
                      ),
                      Text('Hai accumulato ${controller.points} punti!',
                        style: TextStyle(color: _textColor, fontSize: 16),),
                      const SizedBox(height: 25),
                      const Text(
                        'Clicca sulle domande sotto per vedere la risposta corretta.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.allQuestions.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Get.width ~/75,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8
                              ),
                              itemBuilder: (_, index) {
                                final _question = controller.allQuestions[index];
                                AnswerStatus _status = AnswerStatus.notanswered;
                                final _selectedAnswer = _question.selectedAnswer;
                                final _correctAnswer = _question.correctAnswer;
                                if (_selectedAnswer == _correctAnswer){
                                  _status = AnswerStatus.correct;
                                }else {
                                  _status = AnswerStatus.wrong;
                                }
                                return QuestionNumberCard(
                                    index: index+1,
                                    status: _status,
                                    onTap: () {
                                      controller.jumpToQuestion(index, isGoBack: false);
                                      Get.toNamed(AnswerCheckScreen.routeName);
                                    }
                                );
                              }
                          )
                      )
                    ],
                  ),
                )
            ),
            ColoredBox(
              color: Get.isDarkMode ? const Color(0xff232f46)
                :const Color.fromARGB(255, 240, 237, 255),
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: OutlinedButton(
                  onPressed: () {
                    controller.saveQuizResults();
                  },
                  child: const Center(
                    child: Text('Finish'),
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
