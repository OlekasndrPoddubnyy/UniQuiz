import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/firebase/loading_status.dart';
import 'package:uniquiz/src/firebase/references.dart';
import 'dart:convert';
import 'package:uniquiz/src/models/question_paper_model.dart';
import 'package:uniquiz/src/utils/logger.dart';

class DataUploader extends GetxController{
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fireStore = FirebaseFirestore.instance;

    try{
      //read asset folder
      final manifestContent = await DefaultAssetBundle.of(Get.context!)
          .loadString("AssetManifest.json");
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      //separate quiz json files
      final papersInAssets = manifestMap.keys.where((path) =>
      path.startsWith("assets/DB/paper") && path.contains(".json")).toList();

      List<QuestionPaperModel> questionPapers = [];

      for (var paper in papersInAssets) {
        //read content of papers(json files)
        String stringPaperContent = await rootBundle.loadString(paper);
        //add data to model
        questionPapers.add(
            QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
      }

      //upload data to firebase
      var batch = fireStore.batch();

      for (var paper in questionPapers) {
        batch.set(questionPaperRF.doc(paper.id), {
          "title": paper.title,
          "image_url": paper.imageUrl,
          "description": paper.description,
          "time_seconds": paper.timeSeconds,
          "questions_count": paper.questions == null ? 0 : paper.questions!.length
        });

        for (var questions in paper.questions!) {

          final questionPath = questionRF(
              paperId: paper.id, questionId: questions.id!);

          batch.set(questionPath, {
            "question": questions.question,
            "correct_answer": questions.correctAnswer,
          });

          for (var answer in questions.answers!) {
            batch.set(questionPath.collection("answers").doc(answer.identifier),
                {
                  "identifier": answer.identifier,
                  "answer": answer.answer
                });
          }
        }
      }
      await batch.commit();
      loadingStatus.value = LoadingStatus.completed;
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }


}