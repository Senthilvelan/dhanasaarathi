import 'dart:async';
import 'dart:io' show Directory, File, Platform, SocketException;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:queue/queue.dart';
import 'package:synchronized/synchronized.dart' as lockSync;

import '../app.dart';
import '../utils_res/snackbar_helper.dart';
import 'http_service.dart';

/**
 * planned to get data from https://api.mfapi.in/mf,
 * as discussed with Harsh, not using this class,
 * just using mock data
 *
 * */
class HttpServiceImpl implements HttpService {
  late Dio _dio;
  late Dio _dio_nobase;

  @override
  Future<void> init() async {
    //lock is the sync mtd
    var lockInit = lockSync.Lock();

    await lockInit.synchronized(() async {
      Map<String, String> headers = {};

      if (App.accessToken!.isNotEmpty) {
        headers['Authorization'] = 'Bearer ${App.accessToken}';
      }

      headers['X-Platform'] = "";
      if (Platform.isAndroid) {
        headers['X-Platform'] = "android";
      } else if (Platform.isIOS) {
        headers['X-Platform'] = "ios";
      } else {
        headers['X-Platform'] = Platform.operatingSystem;
      }

      _dio = Dio(BaseOptions(
          baseUrl: App.BASE_URL,
          headers: headers,
          receiveDataWhenStatusError: true,
          connectTimeout: 30 * 1000,
          // 30seconds
          receiveTimeout: 30 * 1000 // 30 seconds
          ));

      initializeInterceptors(_dio);
    });
    return;
  }

  @override
  Future<Response> getRequest(String url, {bool needWait = false}) async {
    //Queue to make sure run the task in an order, facing performance issue while running parallel,
    // we can control the LLel action using queue ,parallel: 1 params
    final queueGetReq =
        Queue(delay: const Duration(milliseconds: 300), parallel: 1);

    final result = await queueGetReq.add(() async {
      if (kDebugMode) print(url);

      Response response;

      if (App.accessToken.isNotEmpty) {
        _dio.options.headers['Authorization'] = 'Bearer ${App.accessToken}';
        if (kDebugMode) print(_dio.options.headers);
      }

      try {
        response = await _dio.get(url);
      } on DioError catch (e) {
        if (e.response != null) {
          response = e.response!;

          SnackBarHelper.errorSnackbar(
            msg: "ERROR",
            content: "Status Code ${response.statusCode.toString()}}",
          );
        } else {
          response = Response(
              requestOptions: RequestOptions(
                path: url,
              ),
              statusCode: 503);
        }

        if (needWait) {
          await checkForInternet(getRequest(url));
          await waitForInternet();
        } else {
          // if (e.error.osError.errorCode == 7) {
          if (await getInternetConnectionStatus() == false) {
            SnackBarHelper.showNoInternet();
          }
        }
      }

      return response;
    });
    return result;
  }

  @override
  Future<Response> getRequestNoBase(String url, {dynamic headers}) async {
    final queue = Queue(delay: const Duration(milliseconds: 50), parallel: 1);

    final result = await queue.add(() async {
      if (kDebugMode) print(url);
      Response response;

      try {
        if (_dio_nobase == null) {
          await initNoBase();
        }
        response =
            await _dio_nobase.get(url, options: Options(headers: headers));
      } on DioError catch (e) {
        return Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 501,
        );
      }
      return response;
    });
    return result;
  }

  @override
  Future<Response> postRequestNoBase(String url,
      {dynamic postData, dynamic headers, needWait = false}) async {
    final queue = Queue(delay: const Duration(milliseconds: 50), parallel: 1);

    final result = await queue.add(() async {
      if (kDebugMode) print(_dio_nobase.options.headers);

      await Future.delayed(const Duration(milliseconds: 50));
      Response response;
      try {
        if (headers != null) {
          response = await _dio_nobase.post(url,
              data: postData, options: Options(headers: headers));
        } else {
          response = await _dio_nobase.post(url, data: postData);
        }
      } on DioError catch (e) {
        throw Exception(e);
      }

      return response;
    });
    return result;
  }

  Future<void> checkForInternet(request) async {
    // if (App.internetNotAvail.value ) {
    if (await getInternetConnectionStatus() == false) {
      //StreamSubscription<bool> listener =
      // App.internetNotAvail.stream.listen((event) {
      InternetConnectionCheckerPlus().onStatusChange.listen((status) {
        if (status == true) {
          Future.delayed(const Duration(milliseconds: 300), () async {
            request;
          });
          // getRequest(url);
        }
      });
    } else {
      Future.delayed(const Duration(milliseconds: 300), () async {
        request;
      });
    }
  }

  Future<bool> waitForInternet() async {
    // while (App.internetNotAvail.value) {
    while (await getInternetConnectionStatus() == false) {
      await Future.delayed(
        const Duration(milliseconds: 1300),
      );
    }

    return true;
  }

  getInternetConnectionStatus() async {
    return await InternetConnectionCheckerPlus().hasConnection;
  }

  initializeInterceptors(var _dio) {
    //var lockInterceptors = lockSync.Lock(reentrant: true);

    // lockInterceptors.synchronized(() {
    // Only this block can run (once) until done

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (kDebugMode) {
        print("QA-DEBUG: BASE URL ${options.baseUrl}${options.path}");
      }

      var checking_ssl = true;

      await Future.delayed(const Duration(milliseconds: 50));
      // print(checking_ssl);
      if (checking_ssl == true) {
        return handler.next(options); //continue
      } else {
        // await StringHelper().clearPreferenceDataAndGetOff();
        SnackBarHelper.errorSnackbar(
            msg: "Error", content: "Please try again !");
        handler.reject(new DioError(requestOptions: options));
      }
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError err, ErrorInterceptorHandler handler) async {
      if (err.response?.statusCode == 401 &&
          err.response!.data['error'] == "invalid_token") {
        //clear the access token
        // await StringHelper().clearAcessToken();
        await Future.delayed(const Duration(milliseconds: 50));

        _dio.lock();
        _dio.interceptors.responseLock.lock();
        _dio.interceptors.errorLock.lock();

        onlyRefreshToken().whenComplete(() {
          _dio.unlock();
          _dio.interceptors.responseLock.unlock();
          _dio.interceptors.errorLock.unlock();
        }).then((accessToken) {
          if (accessToken != null && accessToken.trim().length > 0) {
            // Future.delayed(Duration(milliseconds: 50));

            var options = err.response!.requestOptions;
            options.headers['access-token'] = accessToken;
            options.headers['Authorization'] = 'Bearer $accessToken';

            _dio.fetch(options).then(
              // (r) => handler.resolve(r),
              (r) {
                handler.resolve(r);
              },
              onError: (e, handler) {
                handler.reject(e);
              },
            );
          }
        });
        return;
      }
      return handler.next(err); //continue
    }));
    //});
  }

  @override
  Future<void> initNoBase() async {
    var lockInit = lockSync.Lock();
    await lockInit.synchronized(() async {
      _dio_nobase = Dio(BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 30 * 1000, // 30 seconds
          receiveTimeout: 30 * 1000 // 30 seconds
          ));
      await Future.delayed(const Duration(milliseconds: 300));
      initializeInterceptors(_dio_nobase);
    });
  }

  @override
  Future<void> logOutRequest() {
    // TODO: implement logOutRequest
    throw UnimplementedError();
  }

  @override
  Future<String?> onlyRefreshToken() {
    // TODO: implement onlyRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<Response> postRequest1(String url,
      {postData, headers, needWait = false}) {
    // TODO: implement postRequest
    throw UnimplementedError();
  }
}
