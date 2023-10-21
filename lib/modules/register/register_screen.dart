import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_pay/modules/login/login_screen.dart';

import '../../cubit/cubit_app.dart';
import '../../cubit/state_app.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/chach_helper.dart';
import '../../shared/styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool visable = false;
  bool visableConfirm = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  var phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  var isLoginSecure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StateApp>(listener: (context, state) {
      if (CubitApp.get(context).registerModel != null) {
        CacheHelper.SaveData(
            key: "UserId",
            value: CubitApp.get(context).registerModel?.user?.id);
        CacheHelper.SaveData(
                key: "token", value: CubitApp.get(context).registerModel?.token)
            .then((value) {
          navigateToFinish(context: context, widget: const LoginScreen());
        });
      }
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
                              myController: nameController,
                              type: TextInputType.text,
                              validate: (val) {
                                return validInput(val!, 6, 15, 'الاسم');
                              },
                              label: 'الاسم',
                              icon: Icons.person),
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
                          defaultFormField(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  visable = !visable;
                                });
                              },
                              child: Icon(visable
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            colorIcon:
                                cubit.isDark ? Colors.white : defaultColor,
                            color: cubit.isDark ? Colors.white : Colors.black,
                            myController: passwordController,
                            type: TextInputType.visiblePassword,
                            icon: Icons.lock,
                            validate: (val) {
                              return validInput(val!, 6, 6, 'كلمة المرور');
                            },
                            label: 'كلمة المرور',
                            visable: visable,
                          ),
                          defaultFormField(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  visableConfirm = !visableConfirm;
                                });
                              },
                              child: Icon(visableConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            colorIcon:
                                cubit.isDark ? Colors.white : defaultColor,
                            icon: Icons.lock,
                            color: cubit.isDark ? Colors.white : Colors.black,
                            myController: confirmPassword,
                            type: TextInputType.visiblePassword,
                            validate: (val) {
                              return validInput(
                                  val!, 6, 6, 'تأكيد كلمة المرور');
                            },
                            label: 'تأكيد كلمة المرور',
                            visable: visableConfirm,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ConditionalBuilder(
                            condition: state is! OnLoadingRegistration,
                            builder: (context) => defaultButton(
                                text: "انشاء الحساب",
                                color: Colors.white,
                                background: defaultColor,
                                navigate: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.registration(
                                        name: nameController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                  }
                                }),
                            fallback: (context) =>
                                const CircularProgressIndicator(),
                          ),
                        ],
                      ),
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
