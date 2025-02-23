import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String userId;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  // Convert Firestore document to ChatMessage model
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      userId: map['userId'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  // Convert ChatMessage model to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
