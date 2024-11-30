import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/payment_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/payment_provider.dart';

class PaymentController extends GetxController {
  final payment = <Payment>[].obs;

  AuthController authController = Get.find<AuthController>();
  final loading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getPayment();
  }

  void getPayment() async {
    loading.value = true;
    final result =
        await PaymentProvider.getPayment(authController.student_id.value);
    loading.value = false;
    result.fold(
      (List<Payment>? l) {
        this.payment.value = l!;
      },
      (String r) => null,
    );
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
