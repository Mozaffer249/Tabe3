import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: 'aboutAffiliate'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Html(
              data: Get.locale!.languageCode == 'ar'
                  ? controller.appinfo!.aboutAr ?? ''
                  : controller.appinfo!.about ?? '',
              style: {
                "a": Style(
                  backgroundColor: Get.theme.colorScheme.primary,
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
          ],
        ),
      ),
    );
  }
}
