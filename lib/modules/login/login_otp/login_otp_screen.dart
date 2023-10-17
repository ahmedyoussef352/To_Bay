import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:to_pay/layout/home_layout/home_layout.dart';
import 'package:to_pay/shared/components/components.dart';

class LoginOtpScreen extends StatelessWidget {
  final String phone;
   LoginOtpScreen({super.key,required this.phone});
  TextEditingController otpOneController = TextEditingController();
  TextEditingController otpTowController = TextEditingController();
  TextEditingController otpThreeController = TextEditingController();
  TextEditingController otpForeController = TextEditingController();
  TextEditingController otpFiveController = TextEditingController();
  TextEditingController otpSexController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ادخل الرقم السري المكون من 6 ارقام',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
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
                  // يتم تنفيذ هذا المنطق عند تغيير الرمز
                },
                onCompleted: (value) {
                  if(value == "123456"){
                    navigateTo(context: context, widget: HomeLayout());
                  }
                }, appContext: context, 
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOTPTextField(context,controller) {
    return Container(
      width: 50,
      child: TextField(
        controller: controller,
        maxLength: 1,
        obscureText: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counter: Offstage(), // لإخفاء العداد الافتراضي
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1 &&controller!=otpSexController) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 1 &&controller==otpSexController) {
            if("${otpOneController.text}${otpTowController.text}${otpThreeController.text}${otpForeController.text}${otpFiveController.text}${otpSexController.text}"=="123456"){
              navigateTo(context: context, widget: HomeLayout());
            }
          }
        },
      ),
    );
  }
}
