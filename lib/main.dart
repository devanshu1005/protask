import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protask1/app/utils/app_globals.dart';

import 'app/routes/app_pages.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
    await AppGlobals.instance.loadFromStorage();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
