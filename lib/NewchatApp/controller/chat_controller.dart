
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/chat_model.dart';
import '../services/firebase_services.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
fetchMessages();
    super.onInit();
  }
  final ChatService _chatService = ChatService();
  var messagesList = <ChatMessage>[].obs;


  // Fetch messages manually
  Future<void> fetchMessages() async {
    List<ChatMessage> messages = await _chatService.fetchMessages();
    messagesList.value = messages;
  }

  // Send message
  Future<void> sendMessage( String userId, String messageContent) async {
    ChatMessage message = ChatMessage(
      userId: userId,
      message: messageContent,
      timestamp: DateTime.now(),
    );
    await _chatService.sendMessage( message);
    fetchMessages();
  }
}
