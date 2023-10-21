// ignore_for_file: depend_on_referenced_packages, sized_box_for_whitespace, unnecessary_null_comparison, prefer_typing_uninitialized_variables, avoid_print, sort_child_properties_last

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_pay/cubit/bloc_observer.dart';
import 'package:to_pay/shared/components/constance.dart';
import 'package:to_pay/shared/network/local/chach_helper.dart';
import 'package:to_pay/shared/network/remote/dio_helper.dart';
import 'package:to_pay/shared/styles/colors.dart';
import 'cubit/cubit_app.dart';
import 'cubit/state_app.dart';
import 'modules/login/login_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  late Widget startWidget;
  EndPoint.loginToken = CacheHelper.getData(key: 'token');
  // userId = CacheHelper.getData(key: 'userId');
  print(EndPoint.loginToken);
  if (EndPoint.loginToken == null) {
    startWidget = const SplashScreen();
  } else {
    startWidget = const LoginScreen();
  }
  runApp(MyApp(startWidget: startWidget));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final startWidget;
  const MyApp({super.key, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CubitApp(),
        child: BlocConsumer<CubitApp, StateApp>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                title: 'To Pay',
                home: startWidget,
              );
            }));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    width: 150,
                    child: Image.asset(
                      "assets/images/t logo.png",
                      width: 150,
                      height: 150,
                    )),
                Positioned(
                  child: Image.asset(
                    "assets/images/o logo.png",
                    width: 65,
                    height: 65,
                  ).animate().fade(delay: 1000.ms).slideX(delay: 1000.ms),
                  bottom: 25,
                  right: 0,
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        splashIconSize: 350,
        duration: 2500,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        nextScreen: const LoginScreen());
  }
}
