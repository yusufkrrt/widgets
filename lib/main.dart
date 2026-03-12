import 'dart:async';

import 'package:ogrenme/app/app.dart';
import 'package:ogrenme/app/di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await _bootstrap();
}

Future<void> _bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    Get.log('[FlutterError] ${details.exceptionAsString()}', isError: true);
  };

  await DependencyInjection.init();
  runApp(const App());
}
