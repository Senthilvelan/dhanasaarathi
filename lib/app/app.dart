import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/http_service.dart';
import 'network/http_service_impl.dart';

class App {
  static final App _singleton = App._internal();

  factory App() {
    return _singleton;
  }

  App._internal();

  static RxBool internetNotAvail = false.obs;

  static String onboarding_variant = "";

  static late SharedPreferences prefs;

  static String BASE_URL = "https://oracle.fitx.tech/api/";

  static dynamic ipData = {};

  static String accessToken = "";

  // static String accountUuid = "";

  static HttpService _httpService = HttpServiceImpl();

  static HttpService get httpService => _httpService;

  static String currentVersion = "";

  //workout variables
  static RxList friendsList = [].obs;

  static RxList activityNotificationList = [].obs;

  static String loginMtd = "email";

  static Future<void> httpServiceInit() async {
    App._httpService = HttpServiceImpl();
    await App._httpService.init();
    await App._httpService.initNoBase();
  }
}
