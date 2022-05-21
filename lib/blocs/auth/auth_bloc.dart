import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/database/tableOps/categoryOps.dart';
import 'package:samip_grubrr/database/tableOps/category_item_mapping_ops.dart';
import 'package:samip_grubrr/database/tableOps/screenSaverOps.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/screenSaver_api_model.dart';
import 'package:samip_grubrr/network/apiRepo.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/preference_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final ApiRepo apiRepo;
  final PreferenceManager preferenceManager = PreferenceManager();
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

          /// to insert in db
          final CommonResponse dbRes = await screeSaverOps.insert(response);
          // await PreferenceManager().addImageScreenSaver(List.from(response.screenSaverMasters!.map<String>((e) => e.imagePath!)));

          // final res2 = await CategoryOps().getAll();
          // final res4 = await CategoryItemMapOps().getAllFoodItems(100);
          // final res5 = await CategoryItemMapOps().getAllFoodItems(102);

          if (dbRes.data != null) {
            /// init data
            await CategoryOps().initData();
            await CategoryItemMapOps().initData();
            // final CommonResponse getAllData = await screeSaverOps.getAll();
            //
            // List<ScreenSaverMaster> list = List<ScreenSaverMaster>.from(
            //     getAllData.data![BaseApiConstants.val]
            //         .map((x) => ScreenSaverMaster.fromJson(x)));
            // for (var element in list) {
            //   '${element.imagePath} ${element.screenSaverId} is list '.toLog;
            // }
            await preferenceManager.changeLoginStatus(true);
            '${preferenceManager.readUser} after login status change'.toLog;
            // '${preferenceManager.readUser} is login'.toLog;
            emit.call(AuthCompleted(response));
          } else {
            dbRes.message.errorSnackBar;
            emit.call(AuthFailed());
          }
        } catch (e) {
          e.toString().errorSnackBar;
          emit.call(AuthFailed());
        }
      }
    });
  }
}
