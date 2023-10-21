// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_pay/modules/login/login_otp/login_otp_screen.dart';

import '../../cubit/cubit_app.dart';
import '../../cubit/state_app.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool visable = false;
  bool visableConfirm = false;
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var isLoginSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StateApp>(listener: (context, state) {
      // if (CubitApp.get(context).loginModel != null) {
      //   CacheHelper.SaveData(
      //       key: "UserId", value: CubitApp.get(context).loginModel?.user?.id);
      //   CacheHelper.SaveData(
      //           key: "token", value: CubitApp.get(context).loginModel?.token)
      //       .then((value) {
      //     navigateToFinish(context: context, widget: LoginOtpScreen());
      //   });
      // }
    }, builder: (context, state) {
      var cubit = CubitApp.get(context);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/to new logo.png",
                      width: 200,
                      height: 160,
                    ),
                    const Text(
                      "To Pay",
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          fontFamily: "abril",
                          color: defaultColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("اسهل - اسرع - اوفر",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(237, 157, 32, 1))),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultFormField(
                            visable: false,
                            colorIcon:
                                cubit.isDark ? Colors.white : defaultColor,
                            color: cubit.isDark ? Colors.white : Colors.black,
                            myController: phoneController,
                            type: TextInputType.phone,
                            icon: Icons.phone,
                            validate: (val) {
                              return validInput(val!, 11, 11, 'رقم الموبيايل');
                            },
                            label: 'رقم الموبيايل',
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ConditionalBuilder(
                            condition: state is! OnLoadingLogin,
                            builder: (context) => defaultButton(
                                text: "تسجيل الدخول",
                                color: Colors.white,
                                background: defaultColor,
                                navigate: () async {
                                  if (formKey.currentState!.validate()) {
                                    print('ddddddddddddddddddddddddddddd');

                                    print(phoneController.text);
                                    navigateTo(
                                        context: context,
                                        widget: LoginOtpScreen(
                                            phone: phoneController.text));
                                  }
                                }),
                            fallback: (context) =>
                                const CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const FittedBox(
                          child: Text(
                            "ليس لديك حساب ؟",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(
                                  context: context,
                                  widget: const RegisterScreen());
                            },
                            child: const FittedBox(
                              child: Text(
                                "قم بإنشاء حساب",
                                style: TextStyle(
                                    fontSize: 18, color: defaultColor),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
