import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_model.dart';


class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage( ChatMessage message) async {
    await _firestore.collection('chats').doc(FirebaseAuth.instance.currentUser!.uid).collection('messages').add(message.toMap());
  }


  Future<List<ChatMessage>> fetchMessages() async {
    QuerySnapshot snapshot = await _firestore
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .get();

    return snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
