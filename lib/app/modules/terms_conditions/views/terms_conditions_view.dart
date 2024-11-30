import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/terms_conditions_controller.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: 'termsAndConditions'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(
          data: Get.locale!.languageCode == "ar"
              ? controller.appinfo!.termsAr ?? ''
              : controller.appinfo!.terms ?? '',
          style: {
            "a": Style(
              // backgroundColor: Get.theme.backgroundColor,
              color: kMainColor,
            ),
          },
          // onLinkTap: (
          //   String? link,
          //   RenderContext context,
          //   Map<String, String> element,
          //   _,
          // ) async {
          //   if (link != null) {
          //     if (await canLaunchUrlString(link)) {
          //       await launchUrlString(link);
          //     }
          //   }
          // },
        ),
      ),
    );
  }
}
