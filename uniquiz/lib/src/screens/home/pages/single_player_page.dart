import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/constants/colors.dart';
import 'package:uniquiz/src/constants/ui_parameters.dart';
import 'package:uniquiz/src/controllers/home_controller.dart';

import '../../../constants/custom_text_styles.dart';
import '../../../controllers/question_paper/quiz_papers_controller.dart';
import '../../../widgets/content_area.dart';
import '../../../widgets/home/quiz_paper_card.dart';

class SinglePlayerPage extends GetView<HomeController> {
  const SinglePlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) {
          return Container(
            decoration: BoxDecoration(gradient: mainGradient()),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text("Benvenuto",
                            style: detailText.copyWith(
                                fontWeight: FontWeight.bold,

                                color: onSurfaceTextColor
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Cosa vuoi imparare oggi?",
                          style: headerText.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                          child: ContentArea(
                            addRadiusBottom: true,
                            addPadding: false,
                            child: Obx( () => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemCount: _questionPaperController.allPapers.length,
                              itemBuilder: (BuildContext context, int index){
                                return QuizPaperCard(
                                  model: _questionPaperController.allPapers[index],
                                );
                              },
                              separatorBuilder: (BuildContext context, int index){
                                return const SizedBox(height: 20);
                              },
                            ),
                            ),
                      )
                      )
                  ),
                ],
              ),
            ),
          );
        },
      ),
      );
  }
}