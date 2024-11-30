import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/payment_model.dart';

class PaymentProvider {
  static Future<Either<List<Payment>?, String>> getPayment(
      int student_id) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/GetPayslips',
        data: {
          "params": {
            "student_id": student_id,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<Payment> payment = (result['payslips'] as List)
            .map((e) => Payment.fromJson(e))
            .toList();
        return left(payment);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
