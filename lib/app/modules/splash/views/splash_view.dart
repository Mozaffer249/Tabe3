import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body:Obx(
          ()=>
          controller.authController.connectionType == 0 ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.network_check_outlined,size: 48,color: Colors.white),
              Text("No internet connection".tr,style: TextStyle(color: Colors.white),),
            ],
          )):
          Stack(
       children: [
       AppBar(
       automaticallyImplyLeading: false,
         backgroundColor: Colors.transparent,
         elevation: 0.0,
         systemOverlayStyle: SystemUiOverlayStyle(
           statusBarColor: Colors.transparent,
         ),
       ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            'assets/images/topSub.png',
            width: 141.9,
            height: 147.0,
          ),
        ),
        Align(
          alignment: Alignment(-1, 1),
          child: Image.asset('assets/images/dwonSub.png'),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/logowhite.png',
          ),
        ),
        ],
      )
      ));
  }
}
