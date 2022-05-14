import 'dart:developer';

import 'package:samip_grubrr/database/dbRepo.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/screenSaverApiModel.dart';
import 'package:samip_grubrr/tableModels/screenSaversTable.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

class ScreeSaverOps {
  final String tableName = ScreenSaversTable.tableName;

  Future<CommonResponse> insert(ScreenSaverMastersResponse response) async {
    try {
      await Future.forEach(response.screenSaverMasters!,
          (ScreenSaverMaster element) async {
        return await AppDB.instance
            .getDatabase()
            .insert(tableName, element.toJson());
      });
      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> getAll() async {
    try {
      var res = await AppDB.instance
          .getDatabase()
          .rawQuery('SELECT * FROM $tableName');

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
