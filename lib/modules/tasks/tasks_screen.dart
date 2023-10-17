import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("سجل المعاملات"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => Container(
              width: double.infinity,
              padding:
              EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 5),
                  ]),
              child: Text("تم تحويل مبلغ 1000 جنيه الي الرقم 01127502002 "),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 20,),
            itemCount: 15,
          ),
        ),
      ),
    );
  }
}
