// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

const String LANG_CODE = "lang_code";
const String BASE_URL = "base_url";

enum QuestionType
  {
    MultipleChoice,
    TrueFalse,
    MCQ
  }
const int  APP_VERSION = 16;

class CommonVariables {
  static GetStorage userData = GetStorage();
  static GetStorage notification = GetStorage();
  static GetStorage langCode = GetStorage();
  static GetStorage settings = GetStorage();
}
