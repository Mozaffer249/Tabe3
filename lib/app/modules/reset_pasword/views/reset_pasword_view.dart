import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/reset_pasword_controller.dart';

class ResetPaswordView extends GetView<ResetPaswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Padding(
            padding: const EdgeInsets.only(
              top: 80.0,
              left: 59.0,
              right: 72.0,
            ),
            child: Image.asset(
              'assets/images/logowhite.png',
            ),
          ),
          ListView(
            padding: const EdgeInsets.only(
              top: 320.0,
              left: 55.0,
              right: 54.0,
            ),
            children: <Widget>[
              Text(
                'mobile'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14.0),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: ' | 249+',
                  hintStyle: TextStyle(color: Color(0xFFDCDCDC)),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xFFDCDCDC),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20.0),
                child: BasicButton(
                  fontSize: 18.0,
                  label: 'resetPassword'.tr,
                  verticalPadding: 2.0,
                  horzentalPadding: 25.0,
                  onPresed: () {
                    Get.toNamed(Routes.VERIFY);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
