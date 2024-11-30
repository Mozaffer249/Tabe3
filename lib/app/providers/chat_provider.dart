import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';

class ChatProivder {
  static Future<Either<List<Conversation>, String>> getConversations(
      int customerId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getThreads',
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
        List<Conversation> conversations = (result['data'] as List)
            .map((e) => Conversation.fromJson(e))
            .toList();
        return left(conversations);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> deleteConversation(int threadId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/deletemsg',
        data: {
          "params": {
            "thread_id": threadId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<Message>, String>> getMessages(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/readMessages',
        data: {
          "params": request,
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<Message> messages = (result['list_msg'] as List)
            .map((e) => Message.fromJson(e))
            .toList();
        return left(messages);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> markAsRead(
      int customerId, int threadId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/msgReaded',
        data: {
          "params": {
            "customer_id": customerId,
            "thread_id": threadId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> sendMessage(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/SendMessage',
        data: {
          "params": request,
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'] ?? {};
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
