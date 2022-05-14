import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samip_grubrr/database/tableOps/screenSaverOps.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/screenSaverApiModel.dart';
import 'package:samip_grubrr/network/apiRepo.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final ApiRepo apiRepo;
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

          if (dbRes.data != null) {
            final CommonResponse getAllData = await screeSaverOps.getAll();

            List<ScreenSaverMaster> list = List<ScreenSaverMaster>.from(
                getAllData.data![BaseApiConstants.val]
                    .map((x) => ScreenSaverMaster.fromJson(x)));
            list.forEach((element) {
              log('${element.imagePath} ${element.screenSaverId} is list ');
            });
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
