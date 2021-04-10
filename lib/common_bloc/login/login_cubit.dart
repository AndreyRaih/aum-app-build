import 'dart:async';
import 'package:aum_app_build/common_bloc/login/login_state.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  LoginCubit() : super(LoginFormInitial());

  void reset() => emit(LoginFormInitial());

  Future signIn(data) async {
    emit(LoginFormInProgress());
    try {
      await authInstance.signInWithEmailAndPassword(email: data.email, password: data.password);
    } catch (err) {
      emit(LoginFormHasError());
    }
  }

  Future signUp(data) async {
    emit(LoginFormInProgress());
    try {
      UserCredential _creds =
          await authInstance.createUserWithEmailAndPassword(email: data.email, password: data.password);
      await this.createUser(_creds.user, data);
    } catch (err) {
      emit(LoginFormHasError());
    }
  }

  Future createUser(User user, data) async {
    final UserRepository userRepository = UserRepository();
    final ContentRepository contentRespository = ContentRepository();
    String _avatarUrl;
    if (data.avatar != null) {
      String _filename = 'avatar.png';
      await contentRespository.uploadImage(imageToUpload: data.avatar, filename: _filename, id: user.uid);
      _avatarUrl = '$FIRESTORAGE_IMAGE_BASKET_NAME/${user.uid}/$_filename';
    }
    return userRepository.updateUserModel();
  }
}
