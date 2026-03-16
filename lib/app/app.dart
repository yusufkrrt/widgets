import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import eklendi
import 'package:easy_localization/easy_localization.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    builder: (context, child) {
      return child!;
    },
    title: 'App',
    onInit: () => Get.put(AppController()),
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    initialRoute: AppPages.initialRoute,
    getPages: AppPages.routes,
    defaultTransition: Transition.cupertino,

    // Yerelleştirme ayarları (easy_localization üzerinden):
    localizationsDelegates: context.localizationDelegates,
    supportedLocales: context.supportedLocales,
    locale: context.locale,
  );
}