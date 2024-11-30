import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/image_viewer_controller.dart';

class ImageViewer extends GetView<ImageViewerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1919),
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: !controller.imageUrl.startsWith("http")
              ? Image.memory(
                  base64Decode(controller.imageUrl),
                ).image
              : NetworkImage(controller.imageUrl.toString()),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          heroAttributes: PhotoViewHeroAttributes(tag: controller.imageUrl),
        ),
        /* child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: controller.imageUrl,
          placeholder: (context, url) => Image.asset(
            'assets/images/loading.gif',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ), */
      ),
    );
  }
}
