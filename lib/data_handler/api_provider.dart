import 'package:dio/dio.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/result.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/encryption.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/values/strings.dart';

import 'api_keys.dart';

class ApiProvider {
  static late Dio _dio;

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl.baseUrl,
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
        sendTimeout: Duration(seconds: 60),
        // responseType: ResponseType.json,
        // contentType: 'application/json',
        followRedirects: false,
        validateStatus: (status) => true,
        // validateStatus: (status) => status < 500,
        // validateStatus: (status) => [200, 201, 202, 401, 400].contains(status),
      ),
    );

    print(BaseUrl.baseUrl);

    // // if (!BaseUrl.baseUrl.startsWith('https')) {
    //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   };
    // // }
  }

  Future<Options> get _options async {
    // if (Const.packageName.empty) {
    //   try {
    //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //     Const.packageName = packageInfo.packageName;
    //     Const.versionCode = packageInfo.buildNumber;
    //     Const.versionName = packageInfo.version;
    //   } catch (e) {
    //     // print(e);
    //   }
    // }

    return Options(
      headers: {
        'authorization':
            Preference.isUserAvailable ? Preference.user.token : "",
        // 'tmz': Preference.isUserAvailable ? Preference.user.timeZone : 'UTC',
        'pn': Const.packageName,
        'vc': Const.versionCode,
        'vn': Const.versionName,
        'ot': PlatformType.platformType,
        // 'enc': Encryption.privateEncAvailable ? '1' : '0',
      },
    );
  }

  Future<List<dynamic>> getList(
    String endPoint, {
    bool enableParamsLogs = true,
    bool enableResponseLogs = true,
    Map<String, dynamic>? parameters = const {},
    bool reportError = true,
  }) async {
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Params', value: parameters);
    }
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Headers', value: (await _options).headers);
    }

    if (parameters != null &&
        parameters.isNotEmpty &&
        Encryption.publicEncAvailable) {
      parameters = Encryption.instance.encMap(parameters);
    }

    return _dio
        .post(
          endPoint,
          data: FormData.fromMap(parameters ?? {}),
          options: await _options,
        )
        .then((value) {
          if (enableResponseLogs) Logger.r(tag: 'Api $endPoint', value: value);
          if (_isResponseValid(
            response: value,
            endPoint: endPoint,
            reportError: reportError,
          )) {
            // MyAlertDialog()
            //     .setTitle('OK OK')
            //     .setMessage(jsonEncode(value.data))
            //     .setPositiveButton('OK', null)
            //     .setTextSelectable()
            //     .show();
            if (value.data['success'] == true) {
              return value.data['data'] as List;
            }
          }

          return [];
        })
        .catchError((e) {
          Logger.e(
            baseName: runtimeType,
            tag: 'API $endPoint Params',
            value: e,
          );
          if (reportError) reportDioError(endPoint, e);
          return [];
        });
  }

  Future<Result> getResult(
    String endPoint, {
    bool enableParamsLogs = true,
    bool enableResponseLogs = true,
    Map<String, dynamic>? parameters = const {},
    bool reportError = true,
  }) async {
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Params', value: parameters);
    }
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Headers', value: (await _options).headers);
    }

    if (parameters != null &&
        parameters.isNotEmpty &&
        Encryption.publicEncAvailable) {
      parameters = Encryption.instance.encMap(parameters);
    }

    return _dio
        .post(
          endPoint,
          data: FormData.fromMap(parameters ?? {}),
          options: await _options,
        )
        .then((value) {
          if (enableResponseLogs) Logger.r(tag: 'Api $endPoint', value: value);

          if (_isResponseValid(
            response: value,
            endPoint: endPoint,
            reportError: reportError,
          )) {
            return Result.fromJson(value.data);
          }
          return Result(message: Strings.get('somethingWentWrong'));
        })
        .catchError((e) {
          Logger.e(
            baseName: runtimeType,
            tag: 'API $endPoint Params',
            value: e,
          );
          if (reportError) reportDioError(endPoint, e);
          return Result(message: Strings.get('somethingWentWrong'));
        });
  }

  Future<dynamic> postJson(
    String endPoint, {
    Map<String, dynamic>? parameters = const {},
    bool enableParamsLogs = true,
    bool enableResponseLogs = true,
    bool reportError = true,
  }) async {
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Params', value: parameters);
      Logger.m(tag: 'API $endPoint Headers', value: (await _options).headers);
    }

    try {
      // Optional: Uncomment encryption if needed
      // if (Encryption.publicEncAvailable) {
      //   parameters = Encryption.instance.encMap(parameters ?? {});
      // }

      final response = await _dio.post(endPoint, data: parameters);

      if (enableResponseLogs) {
        Logger.r(tag: 'Api $endPoint', value: response);
      }

      if (_isResponseValid(
        response: response,
        endPoint: endPoint,
        reportError: reportError,
      )) {
        return response.data;
      }

      return {'success': false, 'message': response.data['message']};
    } catch (e) {
      Logger.e(tag: 'API $endPoint Error', value: e);
      if (reportError) reportDioError(endPoint, e);
      return {'success': false};
    }
  }

  Future<dynamic> getDynamic(
    String endPoint, {
    bool enableParamsLogs = true,
    bool enableResponseLogs = true,
    Map<String, dynamic>? parameters = const {},
    bool reportError = true,
  }) async {
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Params', value: parameters);
    }
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Headers', value: (await _options).headers);
    }

    if (parameters != null &&
        parameters.isNotEmpty &&
        Encryption.publicEncAvailable) {
      parameters = Encryption.instance.encMap(parameters);
    }

    return _dio
        .post(
          endPoint,
          data: FormData.fromMap(parameters ?? {}),
          options: await _options,
        )
        .then((value) {
          if (enableResponseLogs) Logger.r(tag: 'Api $endPoint', value: value);
          if (_isResponseValid(
            response: value,
            endPoint: endPoint,
            reportError: reportError,
          )) {
            return value.data;
          }
          return {'success': false, 'message': value.data['message']};
        })
        .catchError((e) {
          Logger.e(tag: 'API $endPoint Params', value: e);
          if (reportError) reportDioError(endPoint, e);
          return {'success': false};
        });
  }

  Future<dynamic> getDynamicUsingGet(
    String endPoint, {
    bool enableParamsLogs = true,
    bool enableResponseLogs = true,
    Map<String, dynamic>? parameters = const {},
    bool reportError = true,
  }) async {
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Params', value: parameters);
    }
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Headers', value: (await _options).headers);
    }

    if (parameters != null &&
        parameters.isNotEmpty &&
        Encryption.publicEncAvailable) {
      parameters = Encryption.instance.encMap(parameters);
    }

    return _dio
        .get(
          endPoint,
          data: FormData.fromMap(parameters ?? {}),
          options: await _options,
        )
        .then((value) {
          if (enableResponseLogs) Logger.r(tag: 'Api $endPoint', value: value);
          if (_isResponseValid(
            response: value,
            endPoint: endPoint,
            reportError: reportError,
          )) {
            return value.data;
          }
          return {'success': false};
        })
        .catchError((e) {
          Logger.e(tag: 'API $endPoint Params', value: e);
          if (reportError) reportDioError(endPoint, e);
          return {'success': false};
        });
  }

  Future<int> getInt(
    String endPoint, {
    bool enableParamsLogs = true,
    bool enableResponseLogs = true,
    Map<String, dynamic>? parameters = const {},
    bool reportError = true,
  }) async {
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Params', value: parameters);
    }
    if (enableParamsLogs) {
      Logger.m(tag: 'API $endPoint Headers', value: (await _options).headers);
    }

    if (parameters != null &&
        parameters.isNotEmpty &&
        Encryption.publicEncAvailable) {
      parameters = Encryption.instance.encMap(parameters);
    }

    return _dio
        .post(
          endPoint,
          data: FormData.fromMap(parameters ?? {}),
          options: await _options,
        )
        .then((value) {
          if (enableResponseLogs) Logger.r(tag: 'Api $endPoint', value: value);
          if (_isResponseValid(
            response: value,
            endPoint: endPoint,
            reportError: reportError,
          )) {
            return Helper.parseInt(value.data);
          }
          return 0;
        })
        .catchError((e) {
          Logger.e(tag: 'API $endPoint Params', value: e);
          if (reportError) reportDioError(endPoint, e);
          return 0;
        });
  }

  Future<List<int>?> hitUrl(String url) async {
    return _dio
        .get<List<int>>(url, options: Options(responseType: ResponseType.bytes))
        .then((value) => value.data)
        .catchError((e) => <int>[]);
  }

  void reportDioError(String endPoint, dynamic e) {
    if (e is DioException) {
      Repository.instance.reportError(
        tag: endPoint,
        value: e.message.nullSafe,
        context: 'Api Provider',
        stack: e.stackTrace.toString(),
      );
    } else {
      Repository.instance.reportError(
        tag: endPoint,
        value: e.toString(),
        context: 'Api Provider',
      );
    }
  }
}

bool _isResponseValid({
  required Response response,
  required String endPoint,
  bool reportError = true,
}) {
  if ([200, 201, 202].contains(response.statusCode)) {
    return true;
  }

  if (response.statusCode == 401) {
    Logger.e(
      tag: "$endPoint => !!!!!! STATUS MESSAGE !!!!!!",
      value: '${response.statusCode} :: ${response.statusMessage ?? ''}',
    );
    if (Preference.isLogin) {
      Helper.logOutWithoutAlert();
    }
  }

  if (reportError) {
    Repository.instance.reportError(
      tag: 'Api $endPoint Error',
      value:
          '[${response.statusCode.toString()}] ${response.statusMessage ?? ''}',
      context: endPoint,
      stack: response.data.toString(),
    );
  }

  return false;
}
