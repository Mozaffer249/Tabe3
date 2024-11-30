import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Obx(
              () => Container(
                child: controller.loading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : controller.payment.isEmpty
                        ? Container(
                            child: Center(
                              child: Text('No Payslips Found'.tr),
                            ),
                          )
                        : ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 130.0, 30.0, 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'requiredFees'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff060606),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 3),
                                      child: Text(
                                        "SDG",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffA4A4A4),
                                        ),
                                      ),
                                    ),
                                    // if(controller.payment.isNotEmpty)
                                    Text(
                                      "${controller.payment.first.total}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff04952D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'remainingAmount'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff060606),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 3),
                                      child: Text(
                                        "SDG",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffA4A4A4),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${controller.payment.first.paidAmount}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff04952D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 33.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 154),
                                child: Text(
                                  'payFawry'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff828282),
                                  ),
                                ),
                              ),
                              SizedBox(height: 21),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 80.0),
                                child: BasicButton(
                                  verticalPadding: 10.0,
                                  horzentalPadding: 0.0,
                                  label: 'PayVersion'.tr,
                                  onPresed: () {
                                    Get.defaultDialog(
                                      title: " ",
                                      content: contentDialog(),
                                      titleStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
              ),
            ),
            BasicAppBar(title: 'payment')
          ],
        ),
      ),
    );
  }

  Widget contentDialog() {
    return Column(children: [
      Text(
        "paymentNumber".tr,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xffA5A5A5),
        ),
      ),
      Container(
          height: 30,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 228, 227, 227),
                blurRadius: 5.0,
                spreadRadius: 1,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(child: Text("21535676"))),
      SizedBox(
        height: 20,
      ),
      InkWell(
        onTap: () {},
        child: Container(
          height: 30,
          width: 87,
          decoration: BoxDecoration(
            color: Color(0xff00CDDA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'copy'.tr,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      )
    ]);
  }
}
