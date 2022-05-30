import 'package:auto_route/auto_route.dart';
import 'package:code/config/app_router.gr.dart';
import 'package:code/screens/splash_screen/logic/splash_bloc.dart';
import 'package:code/screens/splash_screen/logic/splash_event.dart';
import 'package:code/screens/splash_screen/logic/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashScreenBloc>(
      create: (context) {
        return SplashScreenBloc()..add(SplashScreenInitialEvent());
      },
      child: const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatefulWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen> {
  late final SplashScreenBloc splashScreenBloc;

  @override
  void initState() {
    splashScreenBloc = BlocProvider.of<SplashScreenBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      bloc: splashScreenBloc,
      listener: (BuildContext context, SplashScreenState state) {
        if (state is NavigateToHomeState) {
          AutoRouter.of(context).replace(const HomeScreen());
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text(
            'Splash Screen',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
