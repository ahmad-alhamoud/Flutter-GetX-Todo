import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/view/pages/home_page.dart';

import 'db/db_helper.dart';
import 'view/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await DBHelper.initDb() ;
  await GetStorage.init() ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'flutter demo',
      debugShowCheckedModeBanner: false,
        theme:  Themes.light ,
          darkTheme : Themes.dark,
         themeMode : ThemeService().theme ,

      home: HomePage(),
    );
  }
}
