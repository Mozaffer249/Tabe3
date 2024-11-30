import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/end_controller.dart';

class EndView extends GetView<EndController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00CDDA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
                height: 190,
                width: 170,
                child: Image.asset("assets/images/Ellipse8.png")),
          ),
          Container(
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff8AE0E5),
                width: 5,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
          ),
          Text(
            "عبد الرحمن وليد",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "مدرسة الشيخ مصطفى الامين",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Container(
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xff8AE0E5),
                width: 5,
              ),
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
          ),
          Text(
            "عبد الرحمن وليد",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "مدرسة الشيخ مصطفى الامين",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                height: 148,
                width: 148,
                child: Image.asset("assets/images/Ellipse9.png")),
          )
        ],
      ),
    );
  }
}
