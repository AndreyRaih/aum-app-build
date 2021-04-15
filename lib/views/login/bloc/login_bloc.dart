import 'package:aum_app_build/common_bloc/user/user_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/views/login/bloc/login_event.dart';
import 'package:aum_app_build/views/login/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserBloc userBloc;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  LoginBloc(this.userBloc) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSignInFailed) {
      print(event.error);
      yield LoginFailure(event.error.message);
    }
    if (event is LoginSignInInit) {
      yield LoginSignIn();
    }
    if (event is LoginSignInVerifyPhone) {
      yield LoginSignIn(phone: event.number);
    }
    if (event is LoginSignInCodeSent) {
      yield* _mapLoginSignInCodeSent(event);
    }
    if (event is LoginSignUpInit) {
      yield LoginSignUp();
    }
    if (event is LoginUserProfileUpdated) {
      yield LoginAumIntroduction();
    }
    if (event is LoginFinishedAumIntroduction) {
      userBloc.add(StartUserSession());
    }
  }

  Stream<LoginState> _mapLoginSignInCodeSent(LoginSignInCodeSent event) async* {
    await authInstance.verifyPhoneNumber(
      phoneNumber: '+1 345-343-2323', // (state as LoginSignIn).phone,
      verificationCompleted: (_) {},
      verificationFailed: (FirebaseAuthException e) => this.add(LoginSignInFailed(e)),
      codeSent: (String verificationId, int resendToken) async {
        PhoneAuthCredential credential =
            PhoneAuthProvider.credential(verificationId: verificationId, smsCode: '435423');
        bool _isNewUser =
            await authInstance.signInWithCredential(credential).then((value) => value.additionalUserInfo.isNewUser);
        if (_isNewUser) {
          this.add(LoginSignUpInit());
        } else {
          userBloc.add(StartUserSession());
        }
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }
}
