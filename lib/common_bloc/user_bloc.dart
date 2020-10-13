import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseAuth authInstance;
  UserBloc({this.authInstance}) : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    _listenUserFirebaseAuthState();
    if (event is UserNotFound) {
      yield* _mapUserNoExistToState();
    } else if (event is SetUser) {
      yield* _mapSetUserToState(event);
    } else if (event is CreateNewUser) {
      yield* _mapCreateUserToState(event);
    } else if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<UserState> _mapUserNoExistToState() async* {
    yield UserNoExist();
  }

  Stream<UserState> _mapSetUserToState(SetUser event) async* {
    yield UserIsDefined(event.user);
  }

  Stream<UserState> _mapCreateUserToState(CreateNewUser event) async* {
    yield UserCreatingProcess();
    try {
      await authInstance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      yield UserIsDefined(authInstance.currentUser);
    } catch (err) {
      yield UserError();
    }
  }

  Stream<UserState> _mapSignInToState(SignIn event) async* {
    yield UserLoginProcess();
    try {
      await authInstance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      yield UserIsDefined(authInstance.currentUser);
    } catch (err) {
      yield UserError();
    }
  }

  void _listenUserFirebaseAuthState() {
    authInstance.authStateChanges().listen((User user) {
      if (user == null) {
        this.add(UserNotFound());
      } else {
        this.add(SetUser(user));
      }
    });
  }
}
