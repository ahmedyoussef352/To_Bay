// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_pay/cubit/cubit_app.dart';
import 'package:to_pay/cubit/state_app.dart';
import 'package:to_pay/models/login_model.dart';
import 'package:to_pay/modules/payment/change_money.dart';
import 'package:to_pay/modules/qr_code/qr_code_screen.dart';
import 'package:to_pay/modules/tasks/tasks_screen.dart';
import 'package:to_pay/shared/components/components.dart';
import 'package:to_pay/shared/network/local/chach_helper.dart';

import '../../shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();

  var codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StateApp>(
        listener: (context, state) {},
        builder: (context, state) {

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(),
                endDrawer: Drawer(
                  width: 250,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Icon(
                          Icons.person,
                          size: 150,
                        ),
                        Text(
                          loginModel?.user == null
                              ? CacheHelper.getData(key: 'name')
                              : loginModel?.user?.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          loginModel?.user == null
                              ? CacheHelper.getData(key: 'phone')
                              : loginModel?.user?.phone,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          titleTextStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          iconColor: Colors.black,
                          leading: const Icon(Icons.qr_code_2_sharp),
                          title: const Text("مشاركة الرمز التعريفي "),
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          titleTextStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          iconColor: Colors.black,
                          leading: const Icon(Icons.task),
                          title: const Text("سجل المعاملات"),
                          onTap: () {
                            navigateTo(
                                context: context, widget: const TasksScreen());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          titleTextStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          iconColor: Colors.black,
                          leading: const Icon(Icons.share),
                          title: const Text("دعوة الاصدقاء"),
                          onTap: () {
                            Share.share(
                                "http://schemas.android.com/apk/res/android");
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          titleTextStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          iconColor: Colors.black,
                          leading: const Icon(Icons.logout),
                          title: const Text("تسجيل الخروج"),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: const DraggableFab(
                    initPosition: Offset(double.infinity, 300),
                    securityBottom: 100,
                    child: Image(
                      image: AssetImage("assets/images/drag.png"),
                      width: 130,
                    )),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 10),
                            ]),
                        clipBehavior: Clip.antiAlias,
                        child: CarouselSlider(
                          items: const [
                            Image(
                              image: AssetImage("assets/images/images.png"),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Image(
                              image: AssetImage("assets/images/images2.png"),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlayInterval: const Duration(seconds: 3),
                            initialPage: 0,
                            reverse: false,
                            enableInfiniteScroll: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            viewportFraction: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 10),
                                  ]),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "كود الدعوة الخاص بك شاركه واربح النقود",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SelectableText(
                                          loginModel?.user == null
                                              ? CacheHelper.getData(
                                                  key: 'user_code')
                                              : loginModel?.user?.user_code,
                                          style: const TextStyle(
                                              color: defaultColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                        text: loginModel?.user == null
                                            ? CacheHelper.getData(
                                                key: 'user_code')
                                            : loginModel?.user?.user_code,
                                      ));
                                      showtoast(
                                          state: toastStates.ERROR,
                                          text: "تم نسخ الكود بنجاح");
                                      // cubit.getUserData();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              237, 157, 32, 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text(
                                        "نسخ الكود",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 10),
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "رصيدك الحالي",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      loginModel?.user == null
                                          ? CacheHelper.getData(key: 'charge')
                                              .toString()
                                          : "${loginModel?.user?.charge}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(
                                child: Image(
                              image: AssetImage(
                                "assets/images/download (1).png",
                              ),
                              width: 100,
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      secondeButton(
                          icon: Icons.attach_money,
                          text: "التحويل",
                          color: const Color.fromRGBO(237, 157, 32, 1),
                          background: Colors.white,
                          navigate: () {
                            navigateTo(
                                context: context, widget: ChangeMoneyScreen());
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      secondeButton(
                          icon: Icons.qr_code_2_rounded,
                          text: "الدفع ",
                          color: const Color.fromRGBO(237, 157, 32, 1),
                          background: Colors.white,
                          navigate: () {
                            navigateTo(
                                context: context, widget: const QrCodeScreen());
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      secondeButton(
                          icon: Icons.credit_card,
                          text: "خدمات التقسيط ",
                          color: const Color.fromRGBO(237, 157, 32, 1),
                          background: Colors.white,
                          navigate: () {}),
                    ]),
                  ),
                )),
          );
        });
  }
}
