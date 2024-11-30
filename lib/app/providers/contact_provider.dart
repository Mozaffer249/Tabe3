import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/contacts_model.dart';

class ContactProvider {
  static Future<Either<List<Contacts>?, String>> getContacts(
      int customerId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getContacts',
        data: {
          "params": {
            "customer_id": customerId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<Contacts> contacts = (result['available_contact'] as List)
            .map((e) => Contacts.fromJson(e))
            .toList();
        return left(contacts);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
