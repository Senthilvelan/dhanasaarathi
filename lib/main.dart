import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/bindings/app_binding.dart';
import 'app/font/my_font_family.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/my_const.dart';
import 'app/utils/sizer.dart';
import 'app/utils_res/color_helper.dart';
import 'ui/1welcome/welcome_screen.dart';

void main() async {
  BindingBase.debugZoneErrorsAreFatal = true;

  // Initialize everything inside the same zone
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      App.prefs = await SharedPreferences.getInstance();

      // await Supabase.initialize(
      //   url: 'https://your-project.supabase.co',
      //   anonKey: 'your-anon-key',
      // );

      await Supabase.initialize(
        url: StringSUPABASE_URL,
        anonKey: StringSUPABASE_,
      );

      runApp(MySaarathiApp());
    },
    (error, stack) {
      // Global error handler
      if (kDebugMode) {
        print('Uncaught error: $error');
        print('Stack trace: $stack');
      }
    },
  );
}

void listenInternet(BuildContext context) {
  InternetConnectionCheckerPlus().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        App.internetNotAvail.value = false;
        if (kDebugMode) {
          print("Internet available: ${App.internetNotAvail.value}");
        }
        break;
      case InternetConnectionStatus.disconnected:
        App.internetNotAvail.value = true;
        if (kDebugMode) {
          print("Internet not available: ${App.internetNotAvail.value}");
        }
        break;
    }
  });
}

class MySaarathiApp extends StatefulWidget {
  @override
  State<MySaarathiApp> createState() => _MyAppState();
}

class _MyAppState extends State<MySaarathiApp> with WidgetsBindingObserver {
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print("App state changed to: ${state.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    listenInternet(context);
    App.httpServiceInit();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) {
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
              ),
            );

            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialBinding: AppBinding(),
              initialRoute: AppRoutes.screenWelcome,
              navigatorKey: NavigationService.navigatorKey,
              defaultTransition: Transition.fadeIn,
              // defaultTransition: Transition.fadeIn,
              transitionDuration: const Duration(milliseconds: 900),
              getPages: AppPages.pages,
              // navigatorObservers: [MyRouteObserver()],
              home: WelcomeScreen(),
              //todo
              // home: FundFullScreen(),

              theme: ThemeData(
                dividerColor: Colors.transparent,
                fontFamily: MyFontFamily.GILROY_SEMIBOLD,
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: primaryBlackColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    NavigationService.screenName = route.settings.name ?? 'unknown';
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      _sendScreenView(route);
    }
    super.didPush(route, previousRoute);
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static String screenName = "";
}
