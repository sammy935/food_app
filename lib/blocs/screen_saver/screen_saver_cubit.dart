import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/database/tableOps/screensaver_ops.dart';
import 'package:samip_grubrr/model/screensaver_api_model.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

import '../../model/common_response.dart';

part 'screen_saver_state.dart';

class ScreenSaverCubit extends Cubit<ScreenSaverState> {
  ScreeSaverOps screeSaverOps = ScreeSaverOps();
  Timer? timer;

  ScreenSaverCubit() : super(ScreenSaverInitial()) {
    getData();
  }

  @override
  close() async {
    super.close();
    timer?.cancel();
  }

  Future<void> getData() async {
    emit(ScreenSaverLoadingInProgress());
    final CommonResponse getAllData = await screeSaverOps.getAll();

    if (getAllData.data != null) {
      List<ScreenSaverMaster> list = List<ScreenSaverMaster>.from(getAllData
          .data![BaseApiConstants.val]
          .map((x) => ScreenSaverMaster.fromJson(x)));

      int i = 0;
      if (list.length > 1) {
        timer?.cancel();
        timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
          emit(ScreenSaverCompleted(list[i]));
          if (i == list.length - 1) {
            i = 0;
          } else {
            i++;
          }
        });
      } else {
        emit(ScreenSaverCompleted(list.first));
      }
    } else {
      emit(ScreenSaverFailed());
    }
  }
}
