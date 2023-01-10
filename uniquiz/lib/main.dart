import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/bindings/initial_binding.dart';
import 'package:uniquiz/src/routes/app_routes.dart';
import 'firebase_options.dart';
import 'src/screens/admin/data_uploader_screen.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  InitialBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'UniQuiz',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: AppRoutes.routes(),
      debugShowCheckedModeBanner: false,
    );
  }
}





Future<void> initFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/*
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  runApp(GetMaterialApp(
    home: DataUploaderScreen(),
  ));
}
 */