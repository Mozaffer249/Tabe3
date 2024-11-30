import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controller/vehavior_controller.dart';

class BehaviorView extends GetView<BehaviorController>{
  @override
  Widget build(BuildContext context) {
    return  Obx(
            () => Scaffold(
      resizeToAvoidBottomInset: true,
      body: LoadingOverlay(
          isLoading: controller.isSubmitting,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: BasicAppBar(title: 'Behaviors'.tr),
              ),
              SizedBox(height: 24),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          if(controller.authController.currentUser!.userType! =="T")
                            _buildTeacherSection()
                          else
                            _buildParentSection()
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
            ),
      floatingActionButton:controller.behaviorerIds.isNotEmpty?
      Padding(
        padding: const EdgeInsets.only(right: 30),
        child: BasicButton(
          label: 'Add Behavior'.tr,
          onPresed: () async {
            Get.toNamed(Routes.ADDBEHAVIOR,arguments: controller.behaviorerIds);
          },
        ),
      ):Container(),
    ));
  }
  Widget _buildStudentRow(Student student, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.grey.shade300,
      elevation: 3,
      child: ListTile(
        title: Row(
          children: [
            Text(
              '${index+1}- ',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: Text('${student.studentName}')),
          ],
        ),
          onTap: () => controller.toggelBehavior(student.studentId!, !student.isAbsent),
        leading: Icon(
          Icons.circle_outlined,
          color: secondaryAppColor,
          size: 50.0,
        ),
        trailing: Checkbox(
          value: student.isAbsent,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return kMainColor;
            }
            return Colors.grey;
          }),
          onChanged: (bool? value) {
          controller.toggelBehavior(student.studentId!, value!);
          },
        ),
      ),
    );
  }

  Widget _buildTeacherSection(){
    return Column(
      children: [
        BasicDropdown<ClassModel>(
          items: controller.authController.availableClasses,
          value: controller.selectedClass,
          onChanged: (ClassModel? value) {
            controller.selectedClass = value;
          },
          builder: (ClassModel value) => Text(value.name!),
        ),
        SizedBox(height: 16),
        ListTile(
          title: Text('Students List'.tr),
        ),
        // BasicTextField(
        //   hintText: 'Search for student'.tr,
        //   onChanged: controller.filter,
        //   prefix: SvgPicture.asset(
        //     'assets/svg/search.svg',
        //     width: 24,
        //     height: 24,
        //   ),
        // ),
        if (controller.isLoading)
          Container(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (controller.students.isEmpty)
          Container(
            height: 300,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    size: 50,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No students in this class'.tr,
                   ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            itemCount: controller.students.length,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final Student student = controller.students.elementAt(index);
              return _buildStudentRow(student, index);
            },
          ),

        SizedBox(height: 15),

      ],
    );
  }

  Widget _buildParentSection(){
    return Column(
      children: [
        if (controller.isLoading)
          Container(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (controller.behaviorList.isEmpty)
          Container(
            height: 500,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Behavior for this student'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            itemCount: controller.behaviorList.value.length,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              var behavior=controller.behaviorList.value[index];
              return Card(
                child: ListTile(
                  leading: Text("${behavior!.length >18?behavior.substring(0,18)+"...":behavior}"),
                 trailing: IconButton(
                     onPressed: (){
                       Get.toNamed(Routes.BEHAVIOR_DETAILS,arguments: behavior);
                       },
                     icon: Icon(Icons.arrow_forward,color: kMainColor,)),
                ),
              );
            },
          ),
         
      ],
    );
  }
}