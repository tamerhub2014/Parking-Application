import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_ui_new/app/login/data/models/user_model.dart';
import 'package:flutter_parking_ui_new/base/toast/error_toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google sign-in
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the Google authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        // Update user document on Firestore with login method
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .update({'loginMethod': LoginMethod.google.text});

        // User already exists, return the user data
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>)
          ..loginMethod = LoginMethod.google;
      } else {
        // User does not exist, create a new user
        User? firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          // Create a UserModel instance
          UserModel newUser = UserModel(
            id: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            loginMethod: LoginMethod.google,
          );

          // Save user details to Firestore
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(firebaseUser.uid)
              .set(newUser.toJson());

          return newUser;
        }
      }

      return null;
    } catch (e) {
      print('Google Sign-In Error: $e');
      showErrorToast("$e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  // Get the current user
  Future<UserModel?> getCurrentUser() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }
}
