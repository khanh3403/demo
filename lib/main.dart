import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/Splash.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/common/text_theme_app.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
import 'package:salesoft_hrm/widgets/refresh_config_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Firebase.apps.isEmpty) {
    final FirebaseOptions firebaseOptions = (Platform.isIOS || Platform.isMacOS)
        ? const FirebaseOptions(
            apiKey: 'AIzaSyCAYT6ri4dd5HPHXfgeoNEajvVpf61ddxg',
            appId: '1:1020659991482:ios:bc27a707c9a387e8789383',
            messagingSenderId: '1020659991482',
            projectId: 'hrm-pmc',
            storageBucket: 'hrm-pmc.appspot.com',
            databaseURL: 'https://hrm-pmc.firebaseio.com/',
          )
        : const FirebaseOptions(
            apiKey: 'AIzaSyDVrIA-hJ-5j7PbvbzaeOf4u8LyBsiO2oo',
            appId: '1:1020659991482:android:24b84c9fbad0b5aa789383',
            messagingSenderId: '1020659991482',
            projectId: 'hrm-pmc',
            storageBucket: 'hrm-pmc.appspot.com',
            databaseURL: 'https://hrm-pmc.firebaseio.com/',
          );

    await Firebase.initializeApp(
      name:"hrm-pmc",
      options: firebaseOptions,
    );
  }
  await init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}
final deviceToken=''.obs; 
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
   String? token = await messaging.getToken();

  if (token != null) {
    deviceToken.value = token;
    print('Device Token: $token');
  } else {
    print('Unable to get Device Token');
  }
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
    );

    Get.put(MainController());
    Get.put(AuthService());

    return GetCupertinoApp(
      debugShowCheckedModeBanner: false,
      getPages: RouterPage.routers,
      home: SplashScreen(),
      // theme:  ,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      locale: const Locale('en', 'US'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
