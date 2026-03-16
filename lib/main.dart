import 'dart:async';

import 'package:ogrenme/app/app.dart';
import 'package:ogrenme/app/di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  await _bootstrap();
}

Future<void> _bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  FlutterError.onError = (details) {
    Get.log('[FlutterError] ${details.exceptionAsString()}', isError: true);
  };

  await DependencyInjection.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
      path: 'assets/translations',
      // Use default loader (JSON). We added locale-specific JSON files
      // `tr-TR.json` and `en-US.json` so no custom asset loader is required.
      fallbackLocale: const Locale('tr', 'TR'),
      child: const App(),
    ),
  );
}
