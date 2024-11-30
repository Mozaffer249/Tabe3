import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
 import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:tabee3_flutter/app/modules/add_lecture/controllers/add_lecture_controller.dart';

enum FilesType { camera, document, gallery }

///getExternalStoragePublicDirectory
enum ExtPublicDir {
  Music,
  PodCasts,
  Ringtones,
  Alarms,
  Notifications,
  Pictures,
  Movies,
  Download,
  DCIM,
  Documents,
  Screenshots,
  Audiobooks,
}

Future<File?> _getImage(BuildContext context, bool fromCamera, {bool enableSquare = true, bool enableOriginal = true, bool enable3x2 = true, bool lockAspectRatio = false, bool hideBottomControls = false}) async
{

 //final AddLectureController addLectureController=Get.find<AddLectureController>();


  final picker = ImagePicker();
  XFile? image = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 500,
      maxWidth: 500);
  if (image != null) {
    List<CropAspectRatioPreset> aspectRatio = [];
    if (enableSquare) {
      aspectRatio.add(CropAspectRatioPreset.square);
    }
    if (enable3x2) {
      aspectRatio.add(CropAspectRatioPreset.ratio5x3);
    }
    if (enableOriginal) {
      aspectRatio.add(CropAspectRatioPreset.original);
    }
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.png,
      // aspectRatio: aspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: kMainColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: aspectRatio.isEmpty
              ? CropAspectRatioPreset.original
              : aspectRatio[0],
          lockAspectRatio: lockAspectRatio,
          hideBottomControls: hideBottomControls,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
    if (croppedFile != null) {
      final file = File(croppedFile.path);
    //  addLectureController.fileType ="image";
      return file;
    }
    return null;
  }
  return null;
}

Future< List<PlatformFile>?>getFile(BuildContext context)async
{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.any,
    );
  if(result !=null)
    {
      List<PlatformFile> files = result.files;
      return files;
    }
  else return null;
}

Future<File?> pickFile(BuildContext context, {bool haveDocument = true}) async {
  File? pickedFile = await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (builder) => bottomSheet(context),
  );
  return pickedFile;
}

Widget bottomSheet(BuildContext context) {
  return SizedBox(
    height: 200,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: const EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(
                  Icons.camera_alt,
                  Colors.pink,
                  "Camera".tr,
                  () async {
                    File? file = await _getImage(context, true);
                    Navigator.of(context).pop(file);
                  },
                ),
                const SizedBox(width: 40),
                iconCreation(
                  Icons.insert_photo,
                  Colors.purple,
                  "Gallery".tr,
                  () async {
                    File? file = await _getImage(context, false);
                    Navigator.of(context).pop(file);
                  },
                ),
              ],
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            // iconCreation(
            //   Icons.file_copy_outlined,
            //   Colors.pink,
            //   "Document".tr,
            //       () async {
            //     File? file = await _getFile(context);
            //     Navigator.of(context).pop(file);
            //   },
            // )
          ],
        ),
      ),
    ),
  );
}

Widget iconCreation(IconData icons, Color color, String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icons,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            // fontWeight: FontWeight.w100,
          ),
        )
      ],
    ),
  );
}

String? getFileBase64(File? image) {
  if (image != null) {
    List<int> bytes = image.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }
  return null;
}

Future<File> getFileFromBase64(String base64File,String extention)async
{
  final decodedBytes = base64Decode(base64File);
  final directory = await getApplicationDocumentsDirectory();
  File file =  File('${directory.path}/loadedfile.${extention}');
  file.writeAsBytesSync(List.from(decodedBytes));

  return file;
}

String getBase64FileExtension(String base64String) {
  switch (base64String.characters.first) {
    case 'I':
      return 'Image';
    case 'P':
      return 'pdf';
    default:
      return 'unknown';
  }
}

Future<String> readAssetsFile(String path) async {
  try {
    String stringContent = await rootBundle.loadString(path);
    return stringContent;
  } catch (e) {
    return "Cannot open file";
  }
}

// Format File Size
String getFileSizeString({required File file, int decimals = 0}) {
  int bytes = file.lengthSync();
  final List<String> suffixes = [
    "B".tr,
    "KB".tr,
    "MB".tr,
    "GB".tr,
    "TB".tr,
  ];
  int i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}

Future<String> createFolderInPublicDir({
  required ExtPublicDir type,
  required String folderName,
}) async {
  String _appDocDir = await _directoryPathESD;

  final List<String> values = _appDocDir.split(Platform.pathSeparator);

  final int dim = values.length - 4; // Android/Data/package.name/files
  _appDocDir = "";

  for (int i = 0; i < dim; i++) {
    _appDocDir += values[i];
    _appDocDir += Platform.pathSeparator;
  }
  _appDocDir += "${type.toString().split('.').last}${Platform.pathSeparator}";
  _appDocDir += folderName;

  if (await Directory(_appDocDir).exists()) {
    return _appDocDir;
  } else {
    //if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder =
        await Directory(_appDocDir).create(recursive: true);
    final String pathNorma = p.normalize(_appDocDirNewFolder.path);

    return pathNorma;
  }
}

Future<String> get _directoryPathESD async {
  Directory? directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  if (directory != null) {
    return directory.path;
  }

  return '';
}
class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}