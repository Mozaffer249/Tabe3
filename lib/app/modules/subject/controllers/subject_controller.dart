// ignore_for_file: invalid_use_of_protected_member

import 'package:dartz/dartz.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/attendance_model.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/student_result.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:tabee3_flutter/app/providers/attendance_provider.dart';
import 'package:tabee3_flutter/app/providers/lesson_provider.dart';
import 'package:tabee3_flutter/app/providers/result_provider.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectController extends GetxController {
  //* Selected student from popup button on home controller
  final Student? student = Get.find<HomeController>().student.value;

  late Subject subject;

  //* Current tab
  final RxInt _currentTab = 0.obs;
  int get currentTab => this._currentTab.value;
  set currentTab(value) => this._currentTab.value = value;

  final Rxn<Lesson>  selectedLesson = Rxn();
  //* Lecture and it's loader
  final _lessons = <Lesson>[].obs;
  List<Lesson> get lessons => this._lessons.value;

  final RxBool _isLoadingLectures = false.obs;
  bool get isLoadingLectures => this._isLoadingLectures.value;

  //* Attendance and it's loader
  final Rxn<Attendance> _attendance = Rxn<Attendance>();
  Attendance? get attendance => _attendance.value;

  final RxBool _isLoadingAttendance = false.obs;
  bool get isLoadingAttendance => this._isLoadingAttendance.value;

  //* Result and it's loader
  final _result = <StudentResult>[].obs;
  List<StudentResult> get result => this._result.value;

  final RxBool _isLoadingResult = false.obs;
  bool get isLoadingResult => this._isLoadingResult.value;

  late final   classId;
  dynamic argumentData = Get.arguments;
  // Loading status of the web page
  var isLoadings = true.obs;
  InAppWebViewController? webViewController;
  void updateLoading(bool loading) {
    isLoadings.value = loading;
  }
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      subject = argumentData[0] as Subject;
      classId =argumentData[1] as int ;
      loadData();
    }
  }

  Future<void> loadData() async {
    getLectures();
    getAttendance();
    getResuts();
  }

  //* Get lectures for this subject
  Future<void> getLectures() async {
    _isLoadingLectures(true);
    final Either<List<Lesson>?, String> result =
        await LessonProvider.getLessons(subject.id!,classId);
    _isLoadingLectures(false);
    result.fold(
      (l) => _lessons(l),
      (r) => null,
    );
  }

  //* Get attedance for this subject
  Future<void> getAttendance() async {
    final request = {
      "student_id": student!.studentId,
      "subject_id": subject.id
    };
    _isLoadingAttendance(true);
    final result = await AttendanceProivder.getAttendnaceForSubject(request);
    _isLoadingAttendance(false);
    result.fold((l) => _attendance(l), (r) => null);
  }

  //* Get result for this subject
  Future<void> getResuts() async {
    final request = {
      "student_id": student!.studentId,
      "subject_id": subject.id,
    };
    _isLoadingResult(true);
    final response = await ResultProvider.getStudentResult(request);
    _isLoadingResult(false);
    response.fold(
      (l) => _result(l),
      (r) => null,
    );
  }
  Future<void> checkAndLaunchExternalURL(String url) async {
    try {
      // Check if the URL is a Google Meet link by using the string
      if (url.contains("meet.google.com")) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          print("Could not launch $url");
        }
      } else {
        selectedLesson.value!.url=url;
        webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
        await Get.toNamed(Routes.LEC_DET);
      }
    } catch (e) {
      print("Error parsing or launching URL: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
