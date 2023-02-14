import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/models/user_model.dart';

import '../../constants/colors.dart';
import '../../constants/ui_parameters.dart';
import '../../controllers/home_controller.dart';

class LeaderboardCard extends GetView<HomeController> {
  const LeaderboardCard({Key? key, required this.model}) : super(key: key);

  final UserLeaderBoard model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Get.isDarkMode ? primaryColorDarkCard
            : cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Row(

          children: [
            Text(' # ${(controller.leaderBoardList.indexOf(model)) + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            const SizedBox(width: 20),
            Text(model.userName),
            const Spacer(),
            const Text('Points:  '),
            Text('${model.points}', style: const TextStyle(fontWeight: FontWeight.bold), ),
          ],
        ),
      )
      );
  }
}