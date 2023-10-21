// ignore_for_file: must_be_immutable, sized_box_for_whitespace, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:to_pay/cubit/cubit_app.dart';
import 'package:to_pay/cubit/state_app.dart';
import 'package:to_pay/layout/home_layout/home_layout.dart';
import 'package:to_pay/modules/login/login_screen.dart';
import 'package:to_pay/shared/components/components.dart';
import 'package:to_pay/shared/network/local/chach_helper.dart';

class LoginOtpScreen extends StatelessWidget {
  final String phone;
  LoginOtpScreen({super.key, required this.phone});
  TextEditingController otpOneController = TextEditingController();
  TextEditingController otpTowController = TextEditingController();
  TextEditingController otpThreeController = TextEditingController();
  TextEditingController otpForeController = TextEditingController();
  TextEditingController otpFiveController = TextEditingController();
  TextEditingController otpSexController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StateApp>(listener: (context, state) {
      if (CubitApp.get(context).loginModel != null) {
        if (state is LoginSuccessful) {
          showtoast(text: 'تم التسجيل بنجاح', state: toastStates.SUCESS);
          CacheHelper.SaveData(
              key: "name", value: CubitApp.get(context).loginModel?.user?.name);
          CacheHelper.SaveData(
              key: "phone",
              value: CubitApp.get(context).loginModel?.user?.phone);
          CacheHelper.SaveData(
              key: "charge",
              value: CubitApp.get(context).loginModel?.user?.charge);
          CacheHelper.SaveData(
              key: "user_code",
              value: CubitApp.get(context).loginModel?.user?.user_code);
          CacheHelper.SaveData(
              key: "UserId", value: CubitApp.get(context).loginModel?.user?.id);
          CacheHelper.SaveData(
                  key: "token", value: CubitApp.get(context).loginModel?.token)
              .then((value) {
            navigateToFinish(context: context, widget: const HomeLayout());
          });
        }
      } else if (state is LoginError) {
        print("error");
        showtoast(
            text: 'خطأ في كلمة المرور او رقم الموبايل الخاص بك',
            state: toastStates.ERROR);
        navigateTo(context: context, widget: const LoginScreen());
      }
    }, builder: (context, state) {
      var cubit = CubitApp.get(context);
      return ConditionalBuilder(
        condition: state is! OnLoadingLogin,
        fallback: (context) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        builder: (context) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'ادخل الرقم السري المكون من 6 ارقام',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  // buildOTPTextField(
                  //     otpOneController,
                  //     otpTowController,
                  //     otpThreeController,
                  //     otpForeController,
                  //     otpFiveController,
                  //     otpSexController),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    length: 6, // عدد الأرقام في الرمز
                    obscureText: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      print(value);
                      // يتم تنفيذ هذا المنطق عند تغيير الرمز
                    },
                    onCompleted: (value) {
                      print('''/////////////////////////////////''');
                      print(phone);
                      print(value);

                      cubit.login(phone: phone, password: value);

                      // if (value == ) {
                      //   cubit.login(password: value.toString(), phone: Endpoint.phoneLogin);
                      //   navigateTo(context: context, widget: HomeLayout());
                      // }
                    },
                    appContext: context,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // Widget buildOTPTextField(
  //     context,
  //     controller,
  //     TextEditingController otpThreeController,
  //     TextEditingController otpForeController,
  //     TextEditingController otpFiveController,
  //     TextEditingController otpSexController) {
  //   return Container(
  //     width: 50,
  //     child: TextField(
  //       controller: controller,
  //       maxLength: 6,
  //       obscureText: true,
  //       textAlign: TextAlign.center,
  //       keyboardType: TextInputType.number,
  //       decoration: const InputDecoration(
  //         counter: Offstage(), // لإخفاء العداد الافتراضي
  //         border: OutlineInputBorder(),
  //       ),
  //       onChanged: (value) {
  //         if (value.length == 1 && controller != otpSexController) {
  //           FocusScope.of(context).nextFocus();
  //         }
  //         if (value.length == 1 && controller == otpSexController) {
  //           if ("${otpOneController.text}${otpTowController.text}${otpThreeController.text}${otpForeController.text}${otpFiveController.text}${otpSexController.text}" ==
  //               "123456") {
  //             navigateTo(context: context, widget: HomeLayout());
  //           }
  //         }
  //       },
  //     ),
  //   );
  //}
}
