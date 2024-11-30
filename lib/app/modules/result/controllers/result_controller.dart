// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tabee3_flutter/app/data/common/pdfinvoiceapi.dart';
import 'package:tabee3_flutter/app/data/models/exams_model.dart';
import 'package:tabee3_flutter/app/data/models/result_model.dart';
import 'package:tabee3_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:tabee3_flutter/app/providers/exam_provider.dart';
import 'package:tabee3_flutter/app/providers/result_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';
import 'package:pdf/widgets.dart' as pdfLib;

import '../../../data/common/pdfapi.dart';

class ResultController extends GetxController {
  // AuthController authController = Get.put(AuthController());
  ScreenshotController screenshotController = ScreenshotController();

  final RxList<Result> _results = <Result>[].obs;
  List<Result> get results => _results.value;

  final RxList<ExamModel> _exams = <ExamModel>[].obs;
  List<ExamModel> get exams => _exams.value;

  final Rxn<ExamModel> _selectedExam = Rxn<ExamModel>();
  ExamModel? get selectedExam => _selectedExam.value;
  set selectedExam(ExamModel? examModel) => _selectedExam.value = examModel;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingResult = false.obs;
  bool get isLoadingResult => _isLoadingResult.value;

  final  _grade = Rxn<ResultSummary>();
  ResultSummary? get grade => this._grade.value;

  final RxBool _isSharing = false.obs;
  bool get isSharing => this._isSharing.value;

  HomeController homeController = Get.find<HomeController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    _isLoading(true);
    await getExams();
    if (_selectedExam.value != null) {
      getResult();
    }
    _isLoading(false);


  }

  Future<void> getExams() async {
    final Either<List<ExamModel>?, String> result =
        await ExamProvider.getExams(homeController.student.value!.studentId!);
    result.fold(
      (List<ExamModel>? l) {
        _exams.value = l!;
        if (_exams.value.isNotEmpty) {
          _selectedExam.value = _exams.first;
        }
      },
      (String r) => null,
    );
  }

  Future<void> getResult() async {
    _isLoadingResult(true);
    final result = await ResultProvider.getResult(
      homeController.student.value!.studentId!,
      _selectedExam.value!.id!,
    );
    _isLoadingResult(false);
    result.fold(
      (l) {
        _results.value = l['data'];
        _grade.value = l['result'];
        // print(_grade.value!.image!+"************************");

      },
      (String r) => null,
    );
  }

  @override
  void onClose() {}

  // Future<void> downloadResult(size) async {
  //   _isSharing(true);
  //
  //   final pdfFile = await PdfInvoiceApi.generate(
  //   result: grade!,
  //   size: size,
  //   className:homeController.student.value!.studentClass! ,
  //   schoolName:  homeController.authController.currentUser!.schoolName!,
  //   examName: selectedExam!.name!,
  //   resultsList: results,
  //   studentName:  homeController.student.value!.studentName!
  //   );
  //   PdfApi.openFile(pdfFile);
  //   _isSharing(false);
  // }

  Future<void> captureAndSharePng() async {
    try {
      final PermissionStatus status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final String directoryName = await createFolderInPublicDir(
        type: ExtPublicDir.DCIM,
        folderName: 'Tabe3',
      );
      final String timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '_')
          .replaceAll(':', '_');
      final String fileName = '${homeController.student.value!.studentName}'
          '_${selectedExam!.name}'
          '_$timestamp.png';
      final String? image = await screenshotController.captureAndSave(
        directoryName,
        fileName: fileName,
      );
      log('image: $image');
      showSnackbar(
        title: 'Success'.tr,
        message: 'downloaded'.trParams({"path": "$image"}),
      );

      /* const String text =
          'Follow @@userName store to get the latest offers.\nVisit @url for more information';
      await Share.shareFiles(
        <String>[image!],
        text: text.trParams(<String, String>{
          "userName": widget.userName,
          "url": 'http://onemile-app.com/api/offer/${widget.userName}'
        }),
      ); */
    } catch (e) {
      log('Error while capturing screen: $e ');
    }
  }

  Future<String> createFolder(String cow) async {
    final Directory dir = Directory('${(await getExternalStorageDirectory())!.path}/$cow');
    final PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await dir.exists()) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }
}
