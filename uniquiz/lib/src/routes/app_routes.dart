import 'package:get/get.dart';
import 'package:uniquiz/src/controllers/home_controller.dart';
import 'package:uniquiz/src/controllers/question_paper/questions_controller.dart';
import 'package:uniquiz/src/controllers/question_paper/quiz_papers_controller.dart';
import 'package:uniquiz/src/screens/screens.dart';

class AppRoutes{
  static List<GetPage> routes() =>[
    GetPage(
        name: SplashScreen.routeName,
        page: () => const SplashScreen(),
        transition: Transition.leftToRightWithFade
    ),
    GetPage(
        name: IntroductionScreen.routeName,
        page: () => const IntroductionScreen()
    ),
    GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
        Get.put(QuizPaperController());
      }),
    ),
    GetPage(
        name: QuestionScreen.routeName,
        page: () => const QuestionScreen(),
        binding: BindingsBuilder(() {
          Get.put<QuestionsController>(QuestionsController());
        })
    ),
    GetPage(
        name: QuizOverviewScreen.routeName,
        page: () => const QuizOverviewScreen(),
    ),
    GetPage(
        name: ResultScreen.routeName,
        page: () => const ResultScreen()
    ),
    GetPage(
        name: AnswerCheckScreen.routeName,
        page: () => const AnswerCheckScreen()
    )
  ];
}