import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_pay/modules/payment/change_money.dart';
import 'package:to_pay/modules/qr_code/qr_code_screen.dart';
import 'package:to_pay/modules/tasks/tasks_screen.dart';
import 'package:to_pay/shared/components/components.dart';

import '../../shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});
  final formKey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 50,),
                Icon(Icons.person,size: 150,),

                Text("محمد فارس",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text("+201127502002",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                ListTile(
                  titleTextStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                  iconColor: Colors.black,
                  leading: Icon(Icons.qr_code_2_sharp),
                  title: Text("مشاركة الرمز التعريفي "),
                  onTap: (){},
                ),SizedBox(height: 20,),
                ListTile(
                  titleTextStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                  iconColor: Colors.black,
                  leading: Icon(Icons.task),
                  title: Text("سجل المعاملات"),
                  onTap: (){
                    navigateTo(context: context, widget: TasksScreen());
                  },
                ),SizedBox(height: 20,),ListTile(
                  titleTextStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                  iconColor: Colors.black,
                  leading: Icon(Icons.share),
                  title: Text("دعوة الاصدقاء"),
                  onTap: (){
                    Share.share(
                        "http://schemas.android.com/apk/res/android");
                  },
                ),SizedBox(height: 20,),
                ListTile(
                  titleTextStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                  iconColor: Colors.black,
                  leading: Icon(Icons.logout),
                  title: Text("تسجيل الخروج"),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
        floatingActionButton:  DraggableFab(
          initPosition: Offset(double.infinity, 300),
            securityBottom: 200,
            child:  Image(
              image: AssetImage("assets/images/drag.png"),
              width: 130,
            )
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 10),
                      ]),
                  clipBehavior: Clip.antiAlias,
                  child: CarouselSlider(
                    items: [
                      Image(
                        image:AssetImage("assets/images/images.png"),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ), Image(
                        image:AssetImage("assets/images/images2.png"),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayInterval: Duration(seconds: 3),
                      initialPage: 0,
                      reverse: false,
                      enableInfiniteScroll: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 10),
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "كود الدعوة الخاص بك شاركه واربح النقود",
                                    style: TextStyle(
                                        color:  Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5,),
                                  SelectableText(
                                    "5181858545",
                                    style: TextStyle(
                                        color:  defaultColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text:  "5181858545"));
                                Fluttertoast.showToast(msg: "تم نسخ الكود بنجاح");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 157, 32, 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 10),
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex:2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("رصيدك الحالي",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 10,
                              ),
                              Text("10000",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 60),),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Image(image: AssetImage("assets/images/download (1).png",),width: 100,))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                secondeButton(icon: Icons.attach_money,text: "التحويل", color: Color.fromRGBO(237, 157, 32, 1), background: Colors.white, navigate: (){
                  navigateTo(context: context, widget: ChangeMoneyScreen());
                }),
                SizedBox(
                  height: 20,
                ),
                secondeButton(icon: Icons.qr_code_2_rounded,text: "الدفع ", color: Color.fromRGBO(237, 157, 32, 1), background: Colors.white, navigate: (){
                  navigateTo(context: context, widget: QrCodeScreen());
                }),SizedBox(
                  height: 20,
                ),
                secondeButton(icon: Icons.credit_card,text: "خدمات التقسيط ", color: Color.fromRGBO(237, 157, 32, 1), background: Colors.white, navigate: (){}),

              ]),
            ),
          )),
    );
  }
}
