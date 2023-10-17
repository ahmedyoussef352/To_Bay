import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:to_pay/shared/components/components.dart';

import '../input_value/input_value_screen.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final qrKey = GlobalKey(debugLabel: "QR");
  Barcode? result;

  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
  bool flash = false;
  TextEditingController valueController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:result==null? Column(
        children: [
           Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCamira,
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex:7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Colors.white)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                controller!.flipCamera();
                              }, icon: Icon(Icons.flip_camera_android,color: Colors.white,)),
                              Spacer(),
                              IconButton(onPressed: (){
                                controller!.toggleFlash();
                                setState(() {
                                  flash=true;
                                });
                              }, icon: Icon(flash?Icons.flash_on_sharp:Icons.flash_off,color: Colors.white,))

                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ):Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${result!.code}"),
              SizedBox(height: 20,),
              TextFormField(
                controller: valueController,
                keyboardType: TextInputType.number,
                maxLength: 5,
                style: TextStyle(
                    color:Colors.black),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "يجب ادخال المبلغ ";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black)),
                    label: FittedBox(
                      child: Text("المبلغ",
                          style: TextStyle(
                              color: Colors.black)),
                    ),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20,),
              defaultButton(text: "ارسال", color: Colors.white, background: Color.fromRGBO(237, 157, 32, 1), navigate: (){
                print("${valueController.text}+ ${result!.code}");
              })
            ],
          ),
        ),
      ),
    );
  }

  void onQRViewCamira(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        controller.pauseCamera();
        result = event;
        // navigateTo(context: context, widget: InputValueScreen(phone:"${event.code}",));

      });
    });
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
