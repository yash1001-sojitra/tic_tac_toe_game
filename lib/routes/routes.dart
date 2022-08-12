import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/string.dart';
import 'package:tic_tac_toe_game/page/home_page.dart';

import '../page/splashscreen/splash_screen.dart';

class Routes {
  late int initScreen;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashscreenRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case homescreenRoute:
        return MaterialPageRoute(builder: (context) => const Homepage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
