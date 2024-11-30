import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
 import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/modules/lecture_details/controller/lecture_details_controller.dart';
import 'package:zoom_widget/zoom_widget.dart';

class LectureDetails extends GetView<LecureDetailsController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: 20),
            child: Column(
              children: [
                BasicAppBar(
                  title: "${controller.lesson.name}",
                ),
                controller.fileType=="pdf"?Container():
                InkWell(
                  onTap: () {

                  },
                  child: Hero(
                    tag: controller.lessonBase64,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.lessonBase64.value,
                        width: 300,
                        height: 300,
                        placeholder: (context, url) => Image.asset('assets/images/loading.gif', fit: BoxFit.cover,),
                        errorWidget: (context, url, error){
                          print(error);
                          return  const Icon(Icons.error);
                        }

                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }


}
