// ignore_for_file: sized_box_for_whitespace, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit_app.dart';
import '../../cubit/state_app.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class ChangeMoneyScreen extends StatelessWidget {
  ChangeMoneyScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var valueController = TextEditingController();
  var phoneSendController = TextEditingController();
  var phoneReciveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StateApp>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CubitApp.get(context);
          final isDesktop = MediaQuery.of(context).size.width >= 500;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("التحويل"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ملحوظه",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: secondeColor,
                                  fontSize: 20),
                            ),
                            Text(
                                "اقل مبلغ لتحويل 15 جنيه و اعلي مبلغ لسحب 10 تلاف",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: cubit.isDark
                                        ? Colors.white
                                        : Colors.black)),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: phoneReciveController,
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              style: TextStyle(
                                  color: cubit.isDark
                                      ? Colors.white
                                      : Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يرجي ادخال الرقم";
                                }
                                if (value.length != 11) {
                                  return "هذا الرقم غير صحيح او غير كامل";
                                }
                                if (!value.startsWith("01")) {
                                  return "يجب ان يبدأ الرقم ب 01";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                fillColor: Colors.white,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: cubit.isDark
                                            ? Colors.white
                                            : Colors.black)),
                                border: const OutlineInputBorder(),
                                hintText: "الرقم المرسل اليه",
                                hintStyle: TextStyle(
                                    color: cubit.isDark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: phoneSendController,
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              style: TextStyle(
                                  color: cubit.isDark
                                      ? Colors.white
                                      : Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يرجي تأكيد الرقم";
                                }
                                if (value.length != 11) {
                                  return "هذا الرقم غير صحيح او غير كامل";
                                }
                                if (!value.startsWith("01")) {
                                  return "يجب ان يبدأ الرقم ب 01";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  fillColor: Colors.white,
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: cubit.isDark
                                              ? Colors.white
                                              : Colors.black)),
                                  border: const OutlineInputBorder(),
                                  hintText: "تأكيد الرقم",
                                  hintStyle: TextStyle(
                                      color: cubit.isDark
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: valueController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: cubit.isDark
                                      ? Colors.white
                                      : Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يرجي ادخال المبلغ";
                                }
                                if (int.parse(value) < 15) {
                                  return "اقل قيمة للتحويل 15 جنيها";
                                }
                                if (int.parse(value) > 10000) {
                                  return "اعلي قيمة للتحويل  10 الاف جنيها";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: cubit.isDark
                                              ? Colors.white
                                              : Colors.black)),
                                  border: const OutlineInputBorder(),
                                  hintText: "ادخل المبلغ",
                                  hintStyle: TextStyle(
                                      color: cubit.isDark
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            defaultButton(
                                text: "تاكيد  التحويل   ",
                                color: secondeColor,
                                background: Colors.white,
                                navigate: () {
                                  if (formKey.currentState!.validate()) {
                                    valueController.text = "";
                                    phoneSendController.text = "";
                                    phoneReciveController.text = "";
                                  }
                                })
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
