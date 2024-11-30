import 'package:get/get.dart';

import '../controllers/start_chat_controller.dart';

class StartChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartChatController());
  }
}
