import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samip_grubrr/blocs/auth/auth_bloc.dart';
import 'package:samip_grubrr/blocs/category_bloc/category_bloc.dart';
import 'package:samip_grubrr/blocs/item/items_bloc.dart';
import 'package:samip_grubrr/blocs/screen_saver/screen_saver_cubit.dart';
import 'package:samip_grubrr/database/dbRepo.dart';
import 'package:samip_grubrr/network/apiRepo.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/preference_manager.dart';
import 'package:samip_grubrr/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppDB.instance.openDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ApiRepo apiRepo = ApiRepo();
  final PreferenceManager preferenceManager = PreferenceManager.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(apiRepo: apiRepo)),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ItemsBloc()),
        BlocProvider(create: (context) => ScreenSaverCubit()),
        // BlocProvider(create: create)
      ],
      child: ScreenUtilInit(
        builder: (c) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetMaterialApp(
            title: 'Grubrr',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: BaseColors.white,
            ),
            initialRoute: preferenceManager.readUser ?? false
                ? Routes.home
                : Routes.login,
            onGenerateRoute: Routes.generateRoute,
          ),
        ),
      ),
    );
  }
}
