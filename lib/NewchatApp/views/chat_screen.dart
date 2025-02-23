import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';
import '../services/Auth_services.dart';


class ChatScreen extends StatelessWidget {
  final ChatController _controller = Get.put(ChatController());
  final AuthService _authService = AuthService();
  final TextEditingController _messageController = TextEditingController();


  ChatScreen();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.messagesList.isEmpty) {
                return const Center(child: Text('No messages'));
              }
              return ListView.builder(
                itemCount: _controller.messagesList.length,
                itemBuilder: (context, index) {
                  final message = _controller.messagesList[index];
                  final isMe = message.userId == _authService.getCurrentUser()?.uid;
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.message),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _controller.sendMessage(

                        _authService.getCurrentUser()!.uid,
                        message,
                      );
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
