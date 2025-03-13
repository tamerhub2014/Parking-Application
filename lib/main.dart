import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_pages.dart';
import 'base/color_data.dart';
import 'base/my_custom_scroll_behavior.dart';
import 'app/notifier/dark_mode.dart';
import 'base/restart_controller.dart';
import 'generated/l10n.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ProfileCubit.instance.getProfile();

  runApp(RestartController(
    child: ChangeNotifierProvider(
        create: (context) => DarkMode(context), child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkThemeProvider = Provider.of<DarkMode>(context);

    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      title: 'Parking Finder',
      initialRoute: AppPages.initialRoute,
      theme: getLightThemeData(),
      darkTheme: getDarkThemeData(),
      themeMode:
          (darkThemeProvider.darkMode) ? ThemeMode.dark : ThemeMode.light,
      routes: AppPages.routes,
    );
  }
}
