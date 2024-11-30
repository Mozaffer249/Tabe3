import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/modules/behavior_details/controller/behavior_details_controller.dart';
import 'package:zoom_widget/zoom_widget.dart';

class BehaviorDetailsView extends GetView<BehaviorDetailsController>
{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: BasicAppBar(title: "Behavior Details".tr),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          Expanded(
            child: Zoom(
              backgroundColor: Colors.white,
              centerOnScale: false,
              child: Html(
                data: controller.behavior,
                style: {
                  "a": Style(
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.underline,
                  ),
                },

              ),
            ),
          )
        ],
      ),
    ),
  );
  }

}