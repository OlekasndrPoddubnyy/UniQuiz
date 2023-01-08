
import 'package:get/get.dart';
import 'package:uniquiz/src/controllers/auth_controller.dart';
import 'package:uniquiz/src/controllers/question_paper/data_uploader.dart';
import 'package:uniquiz/src/services/firebase/firebase_storage_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DataUploader());
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() =>  FirebaseStorageService());
  }

}