import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/models/announcement_model.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AnnouncementCardWidget extends StatelessWidget {
  const AnnouncementCardWidget({
    Key? key,
    required this.announcement,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final Announcement announcement;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Get.size.height * 0.24,
        ),
        decoration: BoxDecoration(
          color: Color(0xff00CDDA),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 196, 194, 194),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 80,
                width: 78,
                child: Image.asset("assets/images/Subtract1.png"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        announcement.name!,
                        style: Get.theme.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        "assets/svg/announcement.svg",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                       "${
                           DateFormat('EEEE, yyyy/MM/dd, hh:mm a',Get.locale!.languageCode).format(announcement.date!)
                       }",
                        style: Get.theme.textTheme.bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Html(
                      data: announcement.body!,
                      style: {
                        "body": Style(
                          color: Colors.white,
                        ),
                        "a": Style(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.underline,
                        ),
                      },
                      // onLinkTap: (link, _, __, ___) async {
                      //   if (link != null) {
                      //     if (await canLaunchUrlString(link)) {
                      //       await launchUrlString(link);
                      //     } else {
                      //       showSnackbar(
                      //           title: null,
                      //           message: 'Cannot open link'
                      //               .trParams({"link": link}));
                      //     }
                      //   }
                      // },
                    ),
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFEC3C3C)),
                  ),
                  child: InkResponse(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete,
                      color: Color(0xFFEC3C3C),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
