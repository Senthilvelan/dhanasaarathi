import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/http_service.dart';
import 'network/http_service_impl.dart';

/**
 *
 *    Singleton class
 * */
class App {
  static final App _singleton = App._internal();

  factory App() {
    return _singleton;
  }

  App._internal();

  static RxBool internetNotAvail = false.obs;


  static late SharedPreferences prefs;

  static String BASE_URL = "";


  static String accessToken = "";


  static HttpService _httpService = HttpServiceImpl();

  static HttpService get httpService => _httpService;

  static String currentVersion = "";


  static Future<void> httpServiceInit() async {
    App._httpService = HttpServiceImpl();
    await App._httpService.init();
    await App._httpService.initNoBase();
  }
}
