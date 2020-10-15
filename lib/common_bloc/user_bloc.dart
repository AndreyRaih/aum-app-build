import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/data_repository.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  DataRepository repository = DataRepository();
  UserBloc() : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is CheckUserLoginState) {
      if (authInstance.currentUser != null) {
        this.add(GetUser());
      } else {
        this.add(UserNotFound());
      }
    }
    if (event is UserNotFound) {
      yield* _mapUserNoExistToState();
    } else if (event is GetUser) {
      yield* _mapSetUserToState();
    } else if (event is SignUp) {
      yield* _mapCreateUserToState(event);
    } else if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<UserState> _mapUserNoExistToState() async* {
    yield UserNoExist();
  }

  Stream<UserState> _mapSetUserToState() async* {
    AumUser user = await repository.getUserModel();
    yield UserIsDefined(user);
  }

  Stream<UserState> _mapCreateUserToState(SignUp event) async* {
    yield UserCreatingProcess();
    try {
      await authInstance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      this.add(GetUser());
    } catch (err) {
      yield UserError();
    }
  }

  Stream<UserState> _mapSignInToState(SignIn event) async* {
    yield UserLoginProcess();
    try {
      await authInstance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      this.add(GetUser());
    } catch (err) {
      yield UserError();
    }
  }
}
