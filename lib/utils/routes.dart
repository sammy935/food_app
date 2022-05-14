import 'package:flutter/material.dart';
import 'package:samip_grubrr/screens/home_page.dart';
import 'package:samip_grubrr/screens/login_page.dart';
import 'package:samip_grubrr/screens/screen_savers_page.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

class Routes {
  static const String home = '/home';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String screenSaver = '/screenSaver';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case landing:
      //   return MaterialPageRoute(builder: (_) => const LandingPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case screenSaver:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ScreenSaversPage(
                  url:
                      '${BaseApiConstants.apiImageLink}${args[BaseApiConstants.url]}',
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
