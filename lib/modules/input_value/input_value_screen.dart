// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_pay/shared/components/components.dart';

class InputValueScreen extends StatelessWidget {
  final String phone;
  InputValueScreen({super.key, required this.phone});
  TextEditingController valueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(phone),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يجب ادخال المبلغ ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      label: FittedBox(
                        child: Text("المبلغ",
                            style: TextStyle(color: Colors.black)),
                      ),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                    text: "ارسال",
                    color: Colors.white,
                    background: const Color.fromRGBO(237, 157, 32, 1),
                    navigate: () {
                      print("${valueController.text}+ $phone");
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
