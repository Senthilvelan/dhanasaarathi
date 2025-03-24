import 'package:dio/dio.dart';

abstract class HttpService {
  Future<void> init();

  Future<void> initNoBase();

  Future<Response> getRequest(String url, {bool needWait = false});

  Future<Response> getRequestNoBase(String url, {dynamic headers});

  Future<Response> postRequest1(String url,
      {dynamic postData, dynamic headers, needWait = false});

  Future<Response> postRequestNoBase(String url,
      {dynamic postData, dynamic headers, needWait = false});

  // Future<Response> putRequest(String url,
  //     {dynamic putData, dynamic headers, needWait = false});
  //
  // Future<Response> patchRequest(String url,
  //     {dynamic putData, dynamic headers, needWait = false});
  //
  // Future<Response> deleteRequest(String url, {bool needWait = false});

  Future<void> logOutRequest();

  Future<String?> onlyRefreshToken();
}
