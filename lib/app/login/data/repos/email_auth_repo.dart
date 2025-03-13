import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/app/login/data/repos/google_auth_repo.dart';
import 'package:flutter_parking_ui_new/app/login/data/repos/user_repo.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Sign up with email and password
  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Create a UserModel instance
        UserModel newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          loginMethod: LoginMethod.email,
        );

        // Save user details to Firestore
        await _firestore
            .collection('Users')
            .doc(user.uid)
            .set(newUser.toJson());

        return newUser;
      }

      return null;
    } catch (e) {
      print('Sign-up Error: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Fetch user details from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(firebaseUser.uid).get();

        if (userDoc.exists) {
          // Update user document on Firestore with login method
          _firestore
              .collection('Users')
              .doc(firebaseUser.uid)
              .update({'loginMethod': LoginMethod.email.text});

          return UserModel.fromJson(userDoc.data() as Map<String, dynamic>)
            ..loginMethod = LoginMethod.email;
        } else {
          print('User document not found in Firestore');
          return null;
        }
      }
      return null;
    } catch (e) {
      print('Sign-in Error: $e');
      return null;
    }
  }

// Update user password
  Future<bool> updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        if (ProfileCubit.instance.user?.loginMethod == LoginMethod.google) {
          await GoogleAuthService().signInWithGoogle();
        }

        await user.updatePassword(newPassword);
        print('Password updated successfully');
        return true;
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      print('Error updating password: $e');
    }

    return false;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
