import 'package:auto_route/auto_route.dart';
import 'package:code/screens/home_screen/home_screen.dart';
import 'package:code/screens/splash_screen/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: HomeScreen),
  ],
)
class $AppRouter {}
