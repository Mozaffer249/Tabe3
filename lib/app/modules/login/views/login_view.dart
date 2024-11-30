import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: kMainColor,
          resizeToAvoidBottomInset: false,
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
              Form(
                key: controller.formKey,
                child: ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 300.0,
                    left: 55.0,
                    right: 54.0,
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'mobile'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            controller: controller.mobileConrtoller,
                            keyboardType: TextInputType.phone,
                            textDirection: TextDirection.ltr,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter mobile'.tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 8,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'mobile'.tr,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFFDCDCDC),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Text(
                            'password'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            controller: controller.passwordConrtoller,
                            obscureText: !controller.showPassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter password'.tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'password'.tr,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFFDCDCDC),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.showPassword =
                                      !controller.showPassword;
                                },
                                icon: Icon(
                                  Icons.visibility,
                                  color: Color(0xFFDCDCDC),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /* TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.RESET_PASWORD);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'forgetPwd'.tr,
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'reset'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00575C),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ), */
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 30.0),
                          child: BasicButton(
                            horzentalPadding: 20.0,
                            label: 'signIn'.tr,
                            verticalPadding: 9.0,
                            fontSize: 18.0,
                            onPresed: () {
                              controller.login();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
