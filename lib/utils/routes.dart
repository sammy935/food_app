import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/blocs/order/order_bloc_cubit.dart';
import 'package:samip_grubrr/screens/home_screen.dart';
import 'package:samip_grubrr/screens/login_page.dart';
import 'package:samip_grubrr/screens/order_screen.dart';
import 'package:samip_grubrr/screens/screen_savers_page.dart';

import '../blocs/category_bloc/category_bloc.dart';
import '../blocs/item/items_bloc.dart';
import '../blocs/screen_saver/screen_saver_cubit.dart';

class Routes {
  static const String home = '/home';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String screenSaver = '/screenSaver';
  static const String order = '/order';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case landing:
      //   return MaterialPageRoute(builder: (_) => const LandingPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => OrderBlocCubit()),
                    BlocProvider(create: (context) => CategoryBloc()),
                    BlocProvider(create: (context) => ItemsBloc()),
                  ],
                  child: const HomePage(),
                ));
      case screenSaver:
        // Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        //
        // String url =
        //     '${BaseApiConstants.apiImageLink}${args[BaseApiConstants.url]}';

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ScreenSaverCubit(),
                  child: const ScreenSaversPage(),
                ));
      case order:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OrderBlocCubit(),
                  child: const OrderScreen(),
                ));
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }

  static MaterialPageRoute unKnowRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $name')),
      ),
    );
  }
}
