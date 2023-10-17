import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_pay/shared/styles/colors.dart';
import 'cubit/cubit_app.dart';
import 'cubit/state_app.dart';
import 'layout/home_layout/home_layout.dart';
import 'modules/login/login_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => CubitApp(),
        child: BlocConsumer<CubitApp, StateApp>(
        listener: (context, state) {
    },
    builder: (context, state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'To Pay',
      home: SplashScreen(),
    );}));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(width: 150,child: Image.asset("assets/images/t logo.png",width: 150,height: 150,)),
            Positioned(child: Image.asset("assets/images/o logo.png",width: 65,height: 65,).animate().fade(delay: 1000.ms).slideX(delay: 1000.ms),bottom: 25,right: 0,),
          ],
        ),
      ],
    ),
        backgroundColor: Colors.white,
        splashIconSize: 350,
        duration: 2500,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        nextScreen: LoginScreen());
  }
}

