import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/routes/AppPages.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/constants/AppConfigs.dart';
import 'package:glive/services/permission_service.dart';
import 'package:glive/theme/AppTheme.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/MeasureSize.dart';
import 'package:oktoast/oktoast.dart';
import 'package:camera/camera.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

bool isTablet(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final aspectRatio = mediaQuery.size.aspectRatio;
  log("Aspect: $aspectRatio");
  final isTablet = aspectRatio < 1.6 && aspectRatio > 0.7;
  return isTablet;
}

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await initServices();
  await GetStorage.init();

  AssetPicker.registerObserve();
  // Enables logging with the photo_manager.
  PhotoManager.setLog(true);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });

  PermissionService.init();
}

Future<void> initServices() async {
  await Get.putAsync<PermissionService>(() async => PermissionService());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(isTablet(context) ? 600 : 428, 984),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MeasureSize(
              onChange: (size) {
                GlobalVariables.height = size.height;
                GlobalVariables.width = size.width;
                setState(() {});
              },
              child: const AppView());
        });
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        transitionDuration: const Duration(milliseconds: 0),
      ),
    );
  }
}
