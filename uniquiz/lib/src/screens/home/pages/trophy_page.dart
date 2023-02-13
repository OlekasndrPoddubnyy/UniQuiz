import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/colors.dart';
import '../../../constants/ui_parameters.dart';
import '../../../controllers/home_controller.dart';
import '../../../widgets/content_area.dart';
import '../../../widgets/home/leaderboard_card.dart';

class TrophyPage extends GetView<HomeController> {
  const TrophyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkTheme = Theme.of(context).brightness;
    bool isDark = Brightness.dark == darkTheme;
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient:  isDark ?  mainGradientDark : mainGradientLight),
          child: SafeArea(
            child: Obx(() => controller.user.value==null?
              const SizedBox()
                  :Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding:const EdgeInsets.only(top: 30),
                          child: const Text("Classifica", style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                            color: onSurfaceTextColor,
                          ),)
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      CircleAvatar(
                        backgroundImage: Image.network(controller.user.value?.photoURL ?? '').image,
                        radius: 35,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        controller.user.value!.displayName??'',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: onSurfaceTextColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Point:  ${controller.points.value}',
                              style: const TextStyle(
                                fontWeight:FontWeight.w900,
                                letterSpacing: 2,
                                fontSize: 20,
                                color: Colors.white60,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Text('Rank #${controller.rank.value}',
                              style: const TextStyle(
                                fontWeight:FontWeight.w900,
                                letterSpacing: 2,
                                fontSize: 20,
                                color: Colors.white60,
                              ),
                            )
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
                                  itemCount: controller.leaderBoardList.length >= 20 ? 20 : controller.leaderBoardList.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return LeaderboardCard(
                                      model: controller.leaderBoardList[index],
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index){
                                    return const SizedBox(height: 10);
                                  },
                                ),
                                ),
                              )
                          )
                      ),
                    ],
              )),
          ),
        )
    );
  }
}
