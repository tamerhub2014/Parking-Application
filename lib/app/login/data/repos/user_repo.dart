import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_ui_new/app/login/data/models/user_model.dart';

abstract class UserRepo {
  static Future<UserModel?> getCurrentUser() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        } else {
          print('User document not found in Firestore');
          return null;
        }
      } else {
        print('No user logged in');
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
}
