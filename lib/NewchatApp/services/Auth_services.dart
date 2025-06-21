import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';


  class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<User?> registerWithEmail(String email, String password,
        String username) async {
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          final userModel = UserModel(
            id: firebaseUser.uid,
            name: username,
            email: email,
            password: password,
            createdAt: DateTime.now(),
          );

          await _firestore
              .collection('userr')
              .doc(firebaseUser.uid)
              .set(userModel.toJson(excludePassword: true));

          return firebaseUser;
        }
        return null;
      } catch (e) {
        print('Error creating user: $e');
        return null;
      }
    }


    // Sign in with Email and Password
    Future<User?> signInWithEmail(String email, String password) async {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user;
      } catch (e) {
        print('Error signing in: $e');
        return null;
      }
    }

    // Get current user
    User? getCurrentUser() {
      return _auth.currentUser;
    }

    // Sign out
    Future<void> signOut() async {
      await _auth.signOut();
    }
  }