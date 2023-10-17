import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_pay/cubit/state_app.dart';
import '../models/login_model.dart';
import '../shared/network/local/chach_helper.dart';
import '../shared/network/remote/dio_helper.dart';

class CubitApp extends Cubit<StateApp> {
  CubitApp() : super(AppInitialState());

  static CubitApp get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  var isDark = CacheHelper.getData(key: "isDark") != null
      ? CacheHelper.getData(key: "isDark")
      : false;

  void changeMode({required bool value}) {
    isDark = value;
    CacheHelper.SaveData(key: "isDark", value: value);
    emit(ChangeThemeModeState());
  }
  void changeindex(int index) {
    currentIndex = index;
    emit(ChangeIndexBottomState());
  }

  // List<Widget> screen = [
  //   HomeScreen(),
  //   ProfileScreen(),
  //   NotificationScreen(),
  //   OrderScreen(),
  //   SettingScreen(),
  // ];

  LoginModel? loginModel;
  void login({required String phone, required String password}) async {
    emit(OnLoadingLogin());
    DioHelper.postData(
        url: "/sanctum/token",
        data: {"phone": phone, "password": password}).then((value) {
      loginModel = LoginModel.fromJson(value?.data);
      print(loginModel!.token);
      print(loginModel!.message);
      emit(LoginSuccessful());
    }).catchError((error) {
      print(error);
      emit(LoginError());
    });
  }
}

