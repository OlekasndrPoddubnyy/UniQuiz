import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';
import 'package:uniquiz/src/firebase/references.dart';

import '../../models/user_model.dart';
import '../../utils/logger.dart';
import '../auth_controller.dart';

extension QuizeResult on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((question) => question.selectedAnswer == question.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount di ${allQuestions.length} sono corrette';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        250 + (correctQuestionCount / allQuestions.length) *
        59 * ( 100 -
        (questionPaperModel.timeSeconds - remainSeconds) /
        questionPaperModel.timeSeconds *
        100);
      points = points/10;
    return points.toStringAsFixed(0);
  }

  Future<void> saveQuizResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    try{
      int totalPoints = 0;
      bool isThere = false;
      final QuerySnapshot<Map<String, dynamic>> docUserQuiz = await userRF.doc(_user.email).collection('myrecent_quizes').get();
      final usersQuiz = docUserQuiz.docs
          .map((quiz) => UsersQuizs.fromSnapshot(quiz))
          .toList();
      for(UsersQuizs quiz in usersQuiz){
        if(quiz.id == questionPaperModel.id) {
          isThere = true;
          totalPoints += int.parse(points);
        }else{
          print(usersQuiz);
          totalPoints += int.parse(quiz.points);
        }
      }
      if(!isThere){
        totalPoints += int.parse(points);
      }
      batch.update(userRF
          .doc(_user.email), {
        "totalPoints" : totalPoints
      });
      batch.set(
          leaderBoardFR
              .doc(_user.email),
          {
            "points": totalPoints,
            "user_id": _user.email,
          });
    }catch (e){
      AppLogger.e(e);
    }
    batch.set(
        userRF
            .doc(_user.email)
            .collection('myrecent_quizes')
            .doc(questionPaperModel.id),
        {
          "points": points,
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": questionPaperModel.id,
          "time": questionPaperModel.timeSeconds - remainSeconds
        });
    await batch.commit();

    navigateToHome();
  }
}
