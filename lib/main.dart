import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/bindings/home_binding.dart';
import 'app/bindings/splash_binding.dart';
import 'app/ui/pages/home_page/home_page.dart';
import 'app/ui/pages/splash_page/splash_page.dart';
import 'core/init/theme/app_theme_light.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  initServices();

  runApp(
    const MyApp(),
  );
}

initServices() async {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, context) => GetMaterialApp(
        enableLog: true,
        navigatorKey: Get.key,
        logWriterCallback: localLogWriter,
        title: "Wallie",
        theme: AppThemeLight.instance.theme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration: Get.defaultTransitionDuration,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr'),
        ],
        initialRoute: "/splash",
        getPages: [
          GetPage(
            name: "/splash",
            page: () => const SplashPage(),
            binding: SplashBinding(),
          ),
          GetPage(
            name: "/home",
            page: () => const HomePage(),
            binding: HomeBinding(),
          ),
        ],
      ),
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    if (kDebugMode) {
      debugPrint(text);

      return;
    }
  }
}
