
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../firebase/firebase_ref.dart';
import '../models/user_model.dart';
import '../utils/logger.dart';
import 'auth_controller.dart';

class HomeController extends GetxController{
  Rxn<User?> user = Rxn();
  RxInt page = 0.obs;
  RxInt points = 0.obs;
  RxInt rank = 0.obs;
  var leaderBoardList = <UserLeaderBoard>[].obs;

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    userPoints();
    userRank();
    super.onReady();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void email() {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'sasha.poddubnyy@gmail.com'
    );
    _launch(emailLaunchUri.toString());
  }

  void newPage(int index) {
    this.page.value = index;
    update();
  }

  Future<void> _launch (String url) async {
    if( !await launch(url)){
      throw 'could not launch $url';
    }
  }

  Future<void> userPoints () async {
    try {
      final myUserdoc = await userRF.doc(user.value!.email).get();
      final myUser = Users.fromSnapshot(myUserdoc);
      points.value = myUser.totalPoints;
    }catch (e){
      AppLogger.e(e);
    }
  }

  Future<void> leaderList () async {
    try{
      final leaderBoardQuery = await leaderBoardFR.orderBy('points', descending: true).get();
      leaderBoardList.value = leaderBoardQuery.docs
          .map((gamers) => UserLeaderBoard.fromSnapshot(gamers))
          .toList();
    } catch (e){
      AppLogger.e(e);
    }
  }

  Future<void> userRank () async {
    try{
      User? myUser = Get.find<AuthController>().getUser();
      try{
        final leaderBoardQuery = await leaderBoardFR.orderBy('points', descending: true).get();
        leaderBoardList.value = leaderBoardQuery.docs
            .map((gamers) => UserLeaderBoard.fromSnapshot(gamers))
            .toList();
        rank.value = 0;
        for (UserLeaderBoard user in leaderBoardList) {
          if (user.userName == myUser?.displayName) {
            rank.value=-1;
            break;
          }
          rank.value++;
        }
        if(rank.value == leaderBoardList.length){
          rank.value = 0;
        }else{
          rank.value = 0;
          for (UserLeaderBoard user in leaderBoardList) {
            if (user.userName == myUser?.displayName) {
              rank.value++;
              break;
            }
            rank.value++;
          }
        }
      } catch (e){
        AppLogger.e(e);
      }
    } catch (e){
      AppLogger.e(e);
    }
  }


}