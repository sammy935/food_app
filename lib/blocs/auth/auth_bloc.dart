import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samip_grubrr/database/tableOps/categoryOps.dart';
import 'package:samip_grubrr/database/tableOps/category_item_mapping_ops.dart';
import 'package:samip_grubrr/database/tableOps/screenSaverOps.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/screenSaver_api_model.dart';
import 'package:samip_grubrr/network/apiRepo.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';
import 'package:samip_grubrr/utils/preference_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final ApiRepo apiRepo;
  final PreferenceManager preferenceManager = PreferenceManager.instance;
  AuthBloc({required this.apiRepo}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        ScreeSaverOps screeSaverOps = ScreeSaverOps();
        emit.call(AuthInProgress());

        try {
          final res = await apiRepo.loginUser(
            password: event.password,
            userName: event.email,
          );
          final response = ScreenSaverMastersResponse.fromJson(res);

          final CommonResponse dbRes = await screeSaverOps.insert(response);
          final res1 = await CategoryOps().initData();
          final res2 = await CategoryOps().getAll();

          final res3 = await CategoryItemMapOps().initData();
          final res4 = await CategoryItemMapOps().getAllFoodItems(100);
          final res5 = await CategoryItemMapOps().getAllFoodItems(102);

          if (dbRes.data != null) {
            final CommonResponse getAllData = await screeSaverOps.getAll();

            List<ScreenSaverMaster> list = List<ScreenSaverMaster>.from(
                getAllData.data![BaseApiConstants.val]
                    .map((x) => ScreenSaverMaster.fromJson(x)));
            for (var element in list) {
              log('${element.imagePath} ${element.screenSaverId} is list ');
            }
            preferenceManager.addUser(true);
            log('${preferenceManager.readUser} is login');
            emit.call(AuthCompleted(response));
          } else {
            emit.call(AuthFailed(dbRes.message));
          }
        } catch (e) {
          emit.call(AuthFailed(e.toString()));
        }
      }
    });
  }
}
