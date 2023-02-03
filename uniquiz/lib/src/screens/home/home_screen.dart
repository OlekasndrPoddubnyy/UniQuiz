import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/controllers/home_controller.dart';
import 'package:uniquiz/src/screens/home/pages/pages.dart';


class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final screens = [
      const SinglePlayerPage(),
      const TrophyPage(),
      const UserPage(),
    ];
    final items = <Widget>[
      const Icon(Icons.home_rounded, size:30),
      const Icon(Icons.emoji_events_rounded, size: 30),
      const Icon(Icons.settings, size: 30)
    ];

    return Scaffold(
      extendBody: true,
      body: Obx(() => screens[controller.page.value]),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: Get.isDarkMode ? Colors.white : Colors.black
          )
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCubicEmphasized,
          color: Get.isDarkMode ? Colors.black87 : Colors.white.withOpacity(0.90),
          index: controller.page.value,
          items: items,
          height: 70,
          onTap: (index) {
            controller.newPage(index);
          },
        ),
      )

    );
  }
}
