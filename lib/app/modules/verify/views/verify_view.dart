import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Stack(
        children: <Widget>[
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
          ListView(
            padding: const EdgeInsets.only(top: 230.0),
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'weSend'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 56.0, bottom: 52.0),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        buildSmallBox(),
                        buildSmallBox(),
                        buildSmallBox(),
                        buildSmallBox(),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'didReceive'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 18.0),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'reSend'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSmallBox() {
    return Container(
      margin: const EdgeInsets.only(right: 22.0),
      width: 45.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0xFF8AE0E5),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
