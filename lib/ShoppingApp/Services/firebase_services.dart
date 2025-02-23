import 'package:chat_app/Models/user_model.dart';
import 'package:chat_app/ShoppingApp/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Common/common_snackbars.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerWithEmail(String email, String password,
      String username, String phone, String userCity) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      await userCredential.user!.sendEmailVerification();

      if (user != null) {
        UserModel1 userModel1 = UserModel1(
            uid: user.uid,
            userName: username,
            email: email,
            phone: phone,
            userImg: " ",
            userDeviceToken: " ",
            country: " ",
            userAddress: " ",
            street: " ",
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            userCity: userCity);

        await _firestore
            .collection('userss')
            .doc(user.uid)
            .set(userModel1.toMap());
      }
      return user;
    } catch (e) {
      print('Error creating user: $e');
      CommonSnackbar.showError(title: 'Error', message: e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      CommonSnackbar.showError(title: 'Error', message: e.toString());
      return null;
    }
  }
}
