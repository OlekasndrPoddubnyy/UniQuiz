import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import '../../firebase/firebase_ref.dart';
import '../../screens/screens.dart';
import '../../utils/logger.dart';
import '../auth_controller.dart';
import 'quiz_papers_controller.dart';
import '../../models/question_paper_model.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final allQuestions = <Questions>[];
  late QuestionPaperModel questionPaperModel;
  Timer? _timer;
  int remainSeconds = 0;
  final time = '00:00'.obs;


  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    loadData(_questionPaper);
    super.onReady();
  }

  @override
  void onClose() {
    if(_timer != null){
      _timer!.cancel();
    }
    super.onClose();
  }

  
/*
  Future<bool> onExitOfQuiz() async{
    return Dialogs.quizEndDialog( );
  }

 */

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer =  Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          timer.cancel();
          complete();
        } else {
          int minutes = remainSeconds~/60;
          int seconds = (remainSeconds%60);
          if(minutes != 0) {
            time.value = "${minutes.toString().padLeft(2,"0")}:${seconds.toString().padLeft(2,"0")}";
          } else {
            time.value = "${seconds.toString().padLeft(2,"0")} sec.";
          }
         remainSeconds--;
        }
      },
    );
    
  }

 
  void loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF.doc(questionPaper.id).collection('questions').get();
      final questions = questionQuery.docs
          .map((question) => Questions.fromSnapshot(question))
          .toList();
      questionPaper.questions = questions;
      for (Questions _question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection('questions')
                .doc(_question.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
    } on Exception catch (e) {
      RegExp exp =  RegExp(r'permission-denied', caseSensitive: false, ); 
      if(e.toString().contains(exp)){
         AuthController _authController = Get.find();
         Get.back();
      }
      AppLogger.e(e);
      loadingStatus.value = LoadingStatus.error;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }

    if (questionPaper.questions != null && questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  Rxn<Questions> currentQuestion = Rxn<Questions>();
  final questionIndex = 0.obs; //_curruntQuestionIndex

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get islastQuestion => questionIndex.value >= allQuestions.length - 1;

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0){
     return;
    } 
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }
  

  void jumpToQuestion(int index, {bool isGoBack = true}){
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if(isGoBack) {
      Get.back();
    }
  }

  void selectAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answers_review_list']);
  }

  String get completedQuiz{
    final answeredQuestionCount = allQuestions.where((question) => question.selectedAnswer != null).toList().length;
    return '$answeredQuestionCount/${allQuestions.length} risposte';
  }

  void complete(){
     _timer!.cancel();
     Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain(){
     Get.find<QuizPaperController>().navigatoQuestions(paper: questionPaperModel);
  }

  void navigateToHome(){
     _timer!.cancel();
     Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}