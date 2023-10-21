// ignore_for_file: constant_identifier_names, camel_case_types, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget buildItems(Map<String, dynamic> data, int index, bool isDesktop, context,
        widget, color) =>
    InkWell(
      onTap: () {
        navigateTo(context: context, widget: widget);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 5)
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(70),
              bottomRight: Radius.circular(70),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/air-conditioner 1.svg"),
              const SizedBox(
                width: 10,
              ),
              Text(
                data["name"],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 25 : 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: Text(
              data["descreption"],
              style: TextStyle(
                color: Colors.white,
                fontSize: isDesktop ? 20 : 13,
              ),
            ),
          )
        ]),
      ),
    );

void navigateTo({required context, required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (route) {
    return false;
  });
}

Widget defaultButton({
  required String text,
  required Color color,
  required Color background,
  required Function() navigate,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1, color: const Color.fromRGBO(237, 157, 32, 1))),
      child: TextButton(
        onPressed: navigate,
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 25),
        ),
      ),
    );

Widget secondeButton({
  required String text,
  required Color color,
  required Color background,
  required Function() navigate,
  required IconData icon,
}) =>
    InkWell(
      onTap: navigate,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1, color: const Color.fromRGBO(237, 157, 32, 1))),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                    color: color, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(icon)
            ],
          )),
    );
void showtoast({required String text, required toastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

enum toastStates { ERROR, WARRING, SUCESS }

Color? toastColor({toastStates? state}) {
  HexColor? color;
  switch (state) {
    case toastStates.ERROR:
      Colors.red;
      // color = HexColor("EFAEAEA5");
      break;
    case toastStates.SUCESS:
      // color = HexColor("#1ABC00");
      Colors.green;
      break;
    case toastStates.WARRING:
      color = HexColor("F8C188FF");
      break;
    case null:
  }
  return color;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    final hexNum = int.parse(hexColor, radix: 16);

    if (hexNum == 0) {
      return 0xff000000;
    }

    return hexNum;
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// Widget defaultFormFieldAuth({
//   required TextEditingController myController,
//   TextInputType? type,
//   IconData? icon,
//   required String label,
//   final String? Function(String?)? validate,
//   bool isPassword = false,
//   final Function()? onTap,
//   final Function()? onTapSuffix,
//   bool isClickable = true,
//   required Color color,
//   required Color colorIcon,
//   required bool suffix,
// }) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 10),
//     child: TextFormField(
//       enabled: isClickable,
//       onTap: onTap,
//       maxLines: 1,
//       controller: myController,
//       keyboardType: type,
//       style: TextStyle(color: color),
//       validator: validate,
//       decoration: InputDecoration(
//           counterText: "",
//           enabledBorder:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//           focusedBorder:
//               OutlineInputBorder(borderSide: BorderSide(color: color)),
//           label: FittedBox(
//             child: Text(label, style: TextStyle(color: color)),
//           ),
//           prefixIcon: Icon(
//             icon,
//             color: colorIcon,
//           ),
//           suffix: suffix == true
//               ? InkWell(
//                   onTap: onTapSuffix,
//                   child: Icon(
//                     Icons.remove_red_eye,
//                     color: Colors.black,
//                   ),
//                 )
//               : Container(),
//           border: const OutlineInputBorder()),
//     ),
//   );
// }

Widget defaultFormField({
  required TextEditingController myController,
  TextInputType? type,
  IconData? icon,
  required String label,
  final String? Function(String?)? validate,
  required Color color,
  required Color colorIcon,
  Widget? suffix,
  required bool visable,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      obscureText: visable,
      maxLines: 1,
      controller: myController,
      keyboardType: type,
      maxLength: 11,
      style: TextStyle(color: color),
      validator: validate,
      decoration: InputDecoration(
          counterText: "",
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color)),
          label: FittedBox(
            child: Text(label, style: TextStyle(color: color)),
          ),
          prefixIcon: Icon(
            icon,
            color: colorIcon,
          ),
          suffixIcon: suffix,
          border: const OutlineInputBorder()),
    ),
  );
}

validInput(val, min, max, String text) {
  if (val.length > max) {
    var messageInputMax = 'يجب الا يزيد $text عن $max';
    return messageInputMax;
  }
  if (val.isEmpty) {
    var messageInputEmpty = 'يجب الا يكون خالي $text';
    return messageInputEmpty;
  }
  if (val.length < min) {
    var messageInputMin = 'يجب الا يقل $text عن $min';
    return messageInputMin;
  }
}

                    // Container(
                    //   width: double.infinity,
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(width: 1, color: defaultColor),
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: Text(
                    //     "-- اختر من الخيارات المتاحة --",
                    //     style: TextStyle(fontSize: 22),
                    //   ),
                    // ),