import 'dart:io';

import 'package:get/get.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/base_strings.dart';

class ApiBaseHelper extends GetConnect {
  final String _baseUrl = "https://staging.grubbrr.com/api/";
  // final pManager = PreferenceManager();
  ApiBaseHelper() : super(timeout: const Duration(minutes: 1));

  Future<bool?> get _checkInternet async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      throw 'No internet';
    }
  }

  Future<dynamic> apiPost(String url, requestBody, Map<String, String> headers,
      {bool isAuthenticated = true}) async {
    // if (isAuthenticated) {
    //   // final token = 'Bearer ${pManager.readUser!.token}';
    //   // headers['Authorization'] = token;
    // }
    if (!(await _checkInternet ?? false)) {
      return null;
    }
    var responseJson;
    // try {
    'REQ=>$requestBody\n\nURL=>${_baseUrl + url}'.toLog;

    var serverResponse = await post(
      _baseUrl + url,
      requestBody,
      headers: headers,
    );
    final decodedJSON = serverResponse.body;
    'response=>${serverResponse.statusCode} ${serverResponse.body}'.toLog;
    responseJson = _transformResponse(serverResponse.statusCode, decodedJSON);
    // } on SocketException {
    //   BaseStrings.internetNotAvailable.alertSnackBar;}
    // } catch (e) {
    //   rethrow;
    // }
    return responseJson;
  }

  Future<dynamic> apiGet(String endPoint, Map<String, String> headers,
      {bool isAuthenticated = true}) async {
    // if (isAuthenticated) {
    //   final token = 'Bearer ${pManager.readUser!.token}';
    //   headers['Authorization'] = token;
    // }
    if (!(await _checkInternet ?? false)) {
      return null;
    }

    late final responseJson;
    try {
      var serverResponse = await get(_baseUrl + endPoint, headers: headers);
      final decodedJSON = serverResponse.body;
      'URL=>${_baseUrl + endPoint}\n\nresponse=>${serverResponse.statusCode} ${serverResponse.body}'
          .toLog;

      responseJson = _transformResponse(serverResponse.statusCode, decodedJSON);
      return decodedJSON;
    } on SocketException {
      BaseStrings.internetNotAvailable.alertSnackBar;
    }
    //} catch (e) {
    //       rethrow;
    //     }
    return responseJson;
  }

  dynamic _transformResponse(statusCode, responseJson) {
    // ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    responseJson.toString().toLog;
    switch (statusCode) {
      case 200:
        return responseJson;
      case 400:
        String? errorResponse = responseJson;

        throw '$errorResponse';

      case 401:
        String? errorResponse = responseJson;

        throw '$errorResponse';
      case 403:
        String? errorResponse = responseJson;

        throw '$errorResponse';
      // Get.offAllNamed(Routes.login);
      default:
        throw BaseStrings.errorOccurs;
    }
  }
}
