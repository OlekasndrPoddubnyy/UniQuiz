import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../firebase/firebase_ref.dart';
import '../../models/question_paper_model.dart';
import '../../screens/screens.dart';
import '../../services/firebase/firebase_storage_service.dart';
import '../../utils/logger.dart';


class QuizPaperController extends GetxController {
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  final allPapers = <QuestionPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList =
          data.docs.map((paper) => QuestionPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imageUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imageUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigatoQuestions({required QuestionPaperModel paper, bool isTryAgain = false}) {
      if (isTryAgain) {
        Get.back();
        Get.toNamed(QuestionScreen.routeName, arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
  }
}
