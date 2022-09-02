import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
  //NotifyHelper().initializationNotifiication();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.Light,
        darkTheme: Themes.Dark,
        themeMode: ThemeServices().theme,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
