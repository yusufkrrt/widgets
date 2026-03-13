import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        builder: (context,child){
          print("---Builder--- App LifeCycle Başlatıldı");
          return child!;
        },
        title: 'App',
        onInit: ()=>Get.put(AppController()),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppPages.initialRoute,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
      );
}

class AppController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    print("---GetX Log--- App LifeCycle Başlatıldı");
  }

}