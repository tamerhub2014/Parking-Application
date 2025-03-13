import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_ui_new/app/login/data/repos/google_auth_repo.dart';
import 'package:flutter_parking_ui_new/app/login/data/repos/user_repo.dart';
import 'package:flutter_parking_ui_new/base/toast/error_toast.dart';
import 'package:flutter_parking_ui_new/base/toast/success_toast.dart';
import 'package:meta/meta.dart';

import '../../../base/pref_data.dart';
import '../data/models/user_model.dart';
import '../data/repos/email_auth_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  factory ProfileCubit() => _instance;
  ProfileCubit._() : super(ProfileInitial());

  static final ProfileCubit _instance = ProfileCubit._();

  static ProfileCubit get instance => _instance;

  final AuthService _emailAuthService = AuthService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? get user =>
      state is ProfileSuccess ? (state as ProfileSuccess).userModel : null;

  void signUpWithEmail(String name, String email, String password) async {
    emit(ProfileLoading());

    final user = await _emailAuthService.signUp(name, email, password);
    if (user != null) {
      PrefData.setLogIn(true);
      emit(ProfileSuccess(user));

      showSuccessToast("Signed up successfully");
    } else {
      emit(ProfileError());

      showErrorToast("Something went wrong: May Be email used before");
    }
  }

  void loginWithEmail(String email, String password) async {
    emit(ProfileLoading());

    final user = await _emailAuthService.signIn(email, password);
    if (user != null) {
      PrefData.setLogIn(true);
      emit(ProfileSuccess(user));

      showSuccessToast("Logged In successfully");
    } else {
      emit(ProfileError());

      showErrorToast("Invalid email or password");
    }
  }

  void loginWithGoogle() async {
    emit(ProfileLoading());

    final user = await _googleAuthService.signInWithGoogle();
    if (user != null) {
      PrefData.setLogIn(true);
      emit(ProfileSuccess(user));

      showSuccessToast("Logged In successfully");
    } else {
      emit(ProfileError());

      showErrorToast("Something Went wrong");
    }
  }

  void getProfile() async {
    emit(ProfileLoading());

    final user = await UserRepo.getCurrentUser();
    if (user != null) {
      PrefData.setLogIn(true);
      emit(ProfileSuccess(user));

      showSuccessToast("Logged In successfully");
    } else {
      emit(ProfileError());
    }
  }

  void updateUser(Map<String, dynamic> map) async {
    emit(ProfileLoading());

    final user = await _googleAuthService.getCurrentUser();
    if (user != null) {
      await _firestore.collection('Users').doc(user.id).update(map);
      final updatedUser = await UserRepo.getCurrentUser();
      if (updatedUser != null) {
        PrefData.setLogIn(true);
        emit(ProfileSuccess(updatedUser));

        showSuccessToast("Profile Updated successfully");
      } else {
        emit(ProfileError());

        showErrorToast("Something Went Wrong while updating user details");
      }
    } else {
      emit(ProfileError());

      // showErrorToast("Something Went Wrong while getting user details");
    }
  }

  void logOut() async {
    await _emailAuthService.signOut();
    await _googleAuthService.signOut();
    PrefData.setLogIn(false);
    emit(ProfileInitial());
    showSuccessToast("Logged out successfully");
  }
}
