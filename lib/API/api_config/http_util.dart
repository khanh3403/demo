import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/common/app_global.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/model/base_model.dart';
import 'package:salesoft_hrm/model/error_model.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;

  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: URLHelper.urlRequest,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    // var headers;
    // String accessToken = Global.profile?.accessToken;
    // if (accessToken != null) {
    //   headers = {
    //     'Authorization': 'Bearer $accessToken',
    //   };
    // }
    return null;
  }

  ///
  /// Kiểm tra quyền đăng nhập người dùng
  ///
  void checkShouldLogout(dynamic data) {
    if (data is List) {
      final listError = BaseModel.listFromJson<ErrorModel>(
          data, (dataMap) => ErrorModel.fromMap(dataMap));
      if (listError.isNotEmpty && listError.first.content?.isNotEmpty == true) {
        showToast(listError.first.content ?? '');
        Get.until((route) => Get.currentRoute == ERouter.mainPage.name);
        // final AccountController accountController = Get.find();
        // accountController.logoutAction();
      }
    }
  }

  Future get(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic>? _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }

    var response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    // checkShouldLogout(response.data);
    return response.data;
  }

  /// restful post
  Future post(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    checkShouldLogout(response.data);
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.put(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    checkShouldLogout(response.data);
    return response.data;
  }

  /// restful patch
  Future patch(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    checkShouldLogout(response.data);
    return response.data;
  }

  /// restful delete
  Future delete(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    checkShouldLogout(response.data);
    return response.data;
  }

  /// restful post form 表单提交操作
  // Future postForm(
  //   String path, {
  //   dynamic params,
  //   Options? options,
  // }) async {
  //   Options requestOptions = options ?? Options();
  //   // Map<String, dynamic> _authorization = getAuthorizationHeader();
  //   // if (_authorization != null) {
  //   //   requestOptions = requestOptions.merge(headers: _authorization);
  //   // }
  //   var response = await dio.post(path,
  //       data: FormData.fromMap(params),
  //       options: requestOptions,
  //       cancelToken: cancelToken);
  //   return response.data;
  // }
}

class ErrorEntity implements Exception {
  int? code;
  String? message;
  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
