// ignore_for_file: invalid_use_of_protected_member

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/chat_provider.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

class ChatController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final RxList<Conversation> _conversations = <Conversation>[].obs;
  List<Conversation> get conversations => _conversations.value;

     RxList<Conversation> _receiverConvs = <Conversation>[].obs;
     List<Conversation> get receiverConvs => _receiverConvs.value;

   bool _isSelectingActive = false;
  set isSelectingActiveSet(bool value) {_isSelectingActive = value;}
  bool get isSelectingActive => _isSelectingActive;


  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isDeletingThread = false.obs;
  bool get isDeletingThread => this._isDeletingThread.value;

  @override
  void onInit() {
    super.onInit();
    getConversations();
  }

  Future<void> getConversations() async {
    _receiverConvs.value.removeRange(0, _receiverConvs.length);
    _isSelectingActive =false;
    _isLoading(true);
    final Either<List<Conversation>, String> result =
        await ChatProivder.getConversations(authController.currentUser!.id!);
    _isLoading(false);
    result.fold(
      (List<Conversation> l) {
        _conversations(l);
        _conversations.value.sort((a, b) => b.listMsg!.first.time!.compareTo(a.listMsg!.first.time!));
        _conversations.refresh();
        // print("**************");
      },
      (String r) => null,
    );
  }

  Future<void> markAsRead() async {
    _isLoading(true);
    final Either<List<Conversation>, String> result =
        await ChatProivder.getConversations(authController.currentUser!.id!);
    _isLoading(false);
    result.fold((List<Conversation> l) {
        _conversations(l);
        _conversations.value.sort((a, b) => a.listMsg!.last.time!.compareTo(b.listMsg!.last.time!));
        _conversations.refresh();
      },
      (String r) => null,
    );
  }

  Future<void> deleteConversation(int threadId) async {
    _isDeletingThread(true);
    final Either<bool, String> result =
        await ChatProivder.deleteConversation(threadId);
    _isDeletingThread(false);
    result.fold(
      (l) {
        // getConversations();
        _conversations.value
            .removeWhere((element) => element.threadId == threadId);
      },
      (String r) => null,
    );
  }

  Future<void> onLongTapListItem(Conversation conversation) async
  {
    if(!_isSelectingActive ) ;{
      _isSelectingActive=true;
    }
    conversation.isSelected = !conversation.isSelected;

    if (conversation.isSelected != null && conversation.isSelected) {
      _receiverConvs.value.add(conversation);
    } else {
      _receiverConvs.value.remove(conversation);
    }

    _receiverConvs.refresh();
    if(_receiverConvs.length==0)_isSelectingActive= false;
    print(conversation.isSelected);
    print(_receiverConvs.toString());

  }

  Future<void>goToMultiMessage()async{
    List<Conversation> conversation =<Conversation>[];

    for(var conv in _receiverConvs)
      {
        conversation.add(conv);
      }

    _isSelectingActive =false;
     for(var conv in _conversations){
       if(conv.isSelected)
       conv.isSelected=false;
     }
    _receiverConvs.removeRange(0,_receiverConvs.length);
    Get.toNamed(
      Routes.MULTI_MESSAGE,
      arguments:[conversation,false],
    );
  }
  @override
  void onClose() {}
}
