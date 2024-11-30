import 'dart:convert';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final image;

  ImageView({this.image});

  Widget _imageView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: image,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child:  Center(
          child: Image.memory(
            base64Decode("${image}"),
          ),
        )
    );
  }
}
