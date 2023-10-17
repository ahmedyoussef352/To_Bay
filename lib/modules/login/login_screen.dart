import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_pay/modules/login/login_otp/login_otp_screen.dart';

import '../../cubit/cubit_app.dart';
import '../../cubit/state_app.dart';
import '../../layout/home_layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/chach_helper.dart';
import '../../shared/styles/colors.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var isLoginSecure = true;

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<CubitApp, StateApp>(listener: (context, state) {
      if (CubitApp.get(context).loginModel != null) {
        CacheHelper.SaveData(
            key: "UserId", value: CubitApp.get(context).loginModel?.user?.id);
        CacheHelper.SaveData(
            key: "token", value: CubitApp.get(context).loginModel?.token)
            .then((value) {
          navigateToFinish(context: context, widget: HomeLayout());
        });
      }
    }, builder: (context, state) {
    var cubit = CubitApp.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/to new logo.png",width: 200,height: 160,),
                  Text("To Pay",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,fontFamily: "abril",color: defaultColor),),
                  SizedBox(height: 20,),
                  Text("اسهل - اسرع - اوفر",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(237, 157, 32, 1))),
                  SizedBox(height: 20,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          style: TextStyle(
                              color:
                              cubit.isDark ? Colors.white : Colors.black),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "يجب ان يكون رقم الموبايل علي الاقل 11 رقما ";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: "",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: cubit.isDark
                                          ? Colors.white
                                          : Colors.black)),
                              label: FittedBox(
                                child: Text("رقم الموبايل",
                                    style: TextStyle(
                                        color: cubit.isDark
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                color:
                                cubit.isDark ? Colors.white : defaultColor,
                              ),
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
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
                                  navigateTo(context: context, widget: LoginOtpScreen(phone: phoneController.text));
                                //
                                //   cubit.login(
                                //       phone: phoneController.text,
                                //       password: passwordController.text);
                                // }
                                // if (state is LoginSuccessful) {
                                //   navigateToFinish(
                                //       context: context, widget: HomeLayout());
                                }
                              }),
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      FittedBox(
                        child: Text(
                          "ليس لديك حساب ؟",
                          style: TextStyle(
                              fontSize: 18,
                              color:
                               Colors.black),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(
                                context: context, widget: RegisterScreen());
                          },
                          child: FittedBox(
                            child: Text(
                              "قم بإنشاء حساب",
                              style:
                              TextStyle(fontSize: 18, color: defaultColor),
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
    );});
  }
}
