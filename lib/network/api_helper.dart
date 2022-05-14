import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/base_strings.dart';

import '../../utils/preference_manager.dart';

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
      return false;
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
    log('REQ=>$requestBody');
    log('URL=>${_baseUrl + url}');
    var serverResponse = await post(
      _baseUrl + url,
      requestBody,
      headers: headers,
    );
    final decodedJSON = serverResponse.body;
    log('response=>${serverResponse.statusCode} ${serverResponse.body}');
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
    print('URL=>${_baseUrl + endPoint}');
    var responseJson;
    try {
      var serverResponse = await get(_baseUrl + endPoint, headers: headers);
      final decodedJSON = serverResponse.body;
      log('response=>${serverResponse.statusCode} ${serverResponse.body}');

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
    print(responseJson.toString());
    switch (statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw '$statusCode is status code';
      case 403:
        throw '$statusCode is status code';
        // Get.offAllNamed(Routes.login);
        break;
      default:
        throw BaseStrings.errorOccurs;
    }
  }
}
