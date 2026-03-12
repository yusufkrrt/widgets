import 'package:ogrenme/app/modules/modules.dart';
import 'package:ogrenme/app/routes/app_paths.dart';
import 'package:get/get.dart';
import '../modules/button/button_binding.dart';
import '../modules/button/button_screen.dart';
import '../modules/text/text_binding.dart';
import '../modules/text/text_screen.dart';
import '../modules/textfield/textfield_binding.dart';
import '../modules/textfield/textfield_screen.dart';
import 'routes.dart';

class AppPages {
  AppPages._();

  static const String initialRoute = AppPaths.splash;

  static final List<GetPage<dynamic>> routes = [
    GetPage<void>(
      name: AppPaths.splash,
      page: SplashScreen.new,
      binding: SplashBindings(),
    ),
    GetPage<void>(
      name: AppPaths.login,
      page: LoginScreen.new,
      binding: LoginBindings(),
    ),
    GetPage<void>(
      name: AppPaths.home,
      page: HomeScreen.new,
      binding: HomeBindings(),
    ),
    GetPage<void>(
      name: AppPaths.dashboard,
      page: DashboardScreen.new,
      binding: DashboardBindings(),
    ),
    GetPage<void>(
      name: AppPaths.fatalError,
      page: FatalErrorScreen.new,
      binding: FatalErrorBindings(),
    ),
      // Widget showcase routes
        GetPage<void>(
          name: AppPaths.button,
          page: () => ButtonScreen(),
          binding: ButtonBinding(),
        ),
        GetPage<void>(
          name: AppPaths.text,
          page: () => TextScreen(),
          binding: TextBinding(),
        ),
        GetPage<void>(
          name: AppPaths.textfield,
          page: () => TextFieldScreen(),
          binding: TextFieldBinding(),
        ),
    GetPage<void>(
      name: AppPaths.canon,
      page: CanonScreen.new,
      binding: CanonBindings(),
    ),
    GetPage<void>(
      name: AppPaths.choose_wigdets,
      page: ChooseWigdetsScreen.new,
      binding: ChooseWigdetsBindings(),
    ),
    GetPage<void>(
      name: AppPaths.list_scroll_widgets,
      page: ListScrollWidgetsScreen.new,
      binding: ListScrollWidgetsBindings(),
    ),
  ];
}
