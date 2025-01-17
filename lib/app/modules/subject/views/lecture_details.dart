import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../controllers/subject_controller.dart';

class LectureDetailsView extends GetView<SubjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          Obx(() {
            return controller.isLoadings.value
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
                : IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                controller.webViewController?.reload();
              },
            );
          })
        ],
      ),
      body: Obx(
            () => InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(controller.selectedLesson.value!.url!.isEmpty?"https://www.google.com/":controller.selectedLesson.value!.url!  ), // Use WebUri for compatibility
              ),
          onWebViewCreated: (controllers) {
            controller.webViewController = controllers;
          },
          onLoadStart: (controllers, url) {
            controller.updateLoading(true);
          },
          onLoadStop: (controllers, url) {
            controller.updateLoading(false);
          },
          onProgressChanged: (controllers, progress) {
            // Show progress loading based on percentage
            if (progress < 100) {
              controller.updateLoading(true);
            } else {
              controller.updateLoading(false);
            }
          },
        ),
      ),
    );
  }
}
