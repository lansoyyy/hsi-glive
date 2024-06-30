import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/routes/AppPages.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/constants/AppConfigs.dart';
import 'package:glive/theme/AppTheme.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return OKToast(
          child: GetMaterialApp(
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)), child: child!);
            },
            initialRoute: AppRoutes.SPLASH,
            getPages: AppPages.list,
            debugShowCheckedModeBanner: false,
            title: AppConfigs.appName,
            locale: Get.locale ?? const Locale('en'),
            fallbackLocale: const Locale('en'),
            supportedLocales: const [Locale('en')],
            defaultTransition: Transition.native,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            // theme: ThemeData(scaffoldBackgroundColor: AppColors.bgEndGradientColor),
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            transitionDuration: const Duration(milliseconds: 0),
          ),
        );
      },
    );
  }
}
