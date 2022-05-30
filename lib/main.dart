import 'package:auto_route/auto_route.dart';
import 'package:code/config/app_router.gr.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [routeObserver],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
