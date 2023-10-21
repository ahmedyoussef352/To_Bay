// ignore_for_file: prefer_if_null_operators, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_pay/cubit/state_app.dart';
import 'package:to_pay/models/register_model.dart';
import 'package:to_pay/shared/components/constance.dart';
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
  // String? phoneLogin;
  LoginModel? loginModel;
  void login({required String phone, required String password}) async {
    emit(OnLoadingLogin());
    DioHelper.postData(
        url: EndPoint.login,
        data: {"phone": phone, "password": password}).then((value) {
      loginModel = LoginModel.fromJson(value?.data);
      EndPoint.loginToken = loginModel!.token!;
      print('00000000000000000000000000000000000');
      print("loginToken is ${EndPoint.loginToken}");

      emit(LoginSuccessful());
    }).catchError((error) {
      print(error);
      emit(LoginError());
    });
  }
  // void otp({required String password}) async {
  //   emit(OnLoadingLogin());
  //   DioHelper.postData(
  //       url: Endpoint.login,
  //       data: {"password": password}).then((value) {
  //     loginModel = LoginModel.fromJson(value?.data);
  //     // Endpoint.loginToken = loginModel!.token!;
  //     print('00000000000000000000000000000000000');
  //     print("loginToken is ${Endpoint.loginToken}");

  //     emit(LoginSuccessful());
  //   }).catchError((error) {
  //     print(error);
  //     emit(LoginError());
  //   });
  // }

  RegisterModel? registerModel;
  void registration(
      {required String name,
      required String password,
      required String phone}) async {
    emit(OnLoadingRegistration());
    DioHelper.postData(
            url: EndPoint.registration,
            data: {"name": name, "phone": phone, "password": password})
        .then((value) {
      registerModel = RegisterModel.fromJson(value?.data);
      EndPoint.regitserToken = registerModel!.token!;
      print('00000000000000000000000000000000000');
      print("registToken is ${EndPoint.regitserToken}");

      emit(RegistrationSuccessful());
    }).catchError((error) {
      print(error);
      emit(RegistrationError());
    });
  }

  LoginModel? userData;
  Future<void> getUserData() async {
    emit(OnLoadingGetUserData());
    await DioHelper.getData(
        url: EndPoint.login,
        data: {"token": EndPoint.loginToken}).then((value) {
      loginModel = LoginModel.fromJson(value!.data);
      print('00000000000000000000000000000000000');
      print(value);
      print('00000000000000000000000000000000000');

      emit(GetUserDataSuccessful());
    }).catchError((error) {
      print(error);
      emit(GetUserDataError());
    });
  }
}
