import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/common_variables.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../routes/app_pages.dart';

class BasicDrawer extends StatelessWidget {
  BasicDrawer({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 190,
            color: Color(0xff00CDDA),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white30,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: authController.currentUser!.image!,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "welcomeUser".trParams(
                                {'name': authController.currentUser!.name!}),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            authController.currentUser!.schoolName!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment(-1.2, 2),
                  child: SvgPicture.asset('assets/svg/appbar.svg'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildListTileDrawer(
                    "main",
                    () => Get.back(),
                    Colors.black,
                  ),
                  //* Check if the user is parent or teacher
                  if (authController.currentUser!.userType == "P")
                    buildListTileDrawer(
                        "subjects",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(
                              Routes.ALL_SUBJECTS,
                              arguments: homeController.studentSubjects,
                            ),
                        Colors.black)
                  else
                    buildListTileDrawer("Attendance",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.ATTENCANCE), Colors.black),

                  if (authController.currentUser!.userType == "P")
                    buildListTileDrawer(
                        "materialTable",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(
                              Routes.SUBJECTS_SCHEDULE,
                            ),
                        Colors.black)
                  else
                    buildListTileDrawer("Lectures",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.LECTURES), Colors.black),

                  if (authController.currentUser!.userType == "T")
                    buildListTileDrawer(
                        "Exams schedule",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.EDIT_EXAMS_SCHEDULE),
                        Colors.black),
                  if (authController.currentUser!.userType == "T")
                    buildListTileDrawer(
                        "View Attendance",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.VIEW_ATTENDANCE),
                        Colors.black),

                  if (authController.currentUser!.userType == "P")
                    buildListTileDrawer("payment",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.PAYMENT), Colors.black)
                  else
                    buildListTileDrawer("Announcement control",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.ANNOUNCEMENTS), Colors.black),

                  if (authController.currentUser!.userType == "P")
                    buildListTileDrawer("addStudent",
                        () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.SIGN_UP), Colors.black),

                  buildListTileDrawer("conversations",
                      () => authController.connectionType==0?enternetConnectioDialog():  Get.toNamed(Routes.CHAT), Colors.black),

                  buildListTileDrawer(
                    "language".tr,
                    () async {
                      final result = await showConfirmationDialog<String>(
                        msg: "chooseLanguage".tr,
                        icon: Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 45,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back(result: 'ar');
                            },
                            child: Text('العربية'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back(result: 'en');
                            },
                            child: Text('English'),
                          ),
                        ],
                      );
                      if (result != null) {
                        CommonVariables.langCode.write(LANG_CODE, result);
                        Get.updateLocale(Locale(result));
                      }
                    },
                    Colors.black,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/drawer.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildListTileDrawer("termsAndConditions", () {

                          Get.toNamed(Routes.TERMS_CONDITIONS);

                        }, Colors.white),
                        buildListTileDrawer("privacyPolicy", ()async {
                          if (await canLaunchUrlString("https://www.freeprivacypolicy.com/live/e07cf8d6-796a-45d4-953f-9192b9cca4da")) {
                          await launchUrlString("https://www.freeprivacypolicy.com/live/e07cf8d6-796a-45d4-953f-9192b9cca4da");
                          }
                        //  Get.toNamed(Routes.PRIVACY_POLICY);
                        }, Colors.white),
                        buildListTileDrawer("aboutAffiliate", () {
                          Get.toNamed(Routes.ABOUT);
                        }, Colors.white),
                        buildListTileDrawer("signOut", () {
                          authController.logout();
                        }, Colors.white),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListTileDrawer(String name, Function() onpressed, Color color) {
    return SizedBox(
      height: 50,
      child: ListTile(
        onTap: onpressed,
        title: Text(
          name.tr,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: color,
          ),
        ),
      ),
    );
  }
}
