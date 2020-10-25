import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;
  UserRepository repository;
  UserBloc() : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is InitializeUserSession) {
      // authInstance.signOut();
      yield* _mapUserInitializationState();
    } else if (event is GetUser) {
      yield* _mapSetUserToState();
    } else if (event is SignUp) {
      yield* _mapCreateUserToState(event);
    } else if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<UserState> _mapUserInitializationState() async* {
    if (authInstance.currentUser != null) {
      repository = UserRepository(userId: authInstance.currentUser.uid);
      this.add(GetUser());
    } else {
      yield UserNoExist();
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
    yield UserLoading();
    try {
      await authInstance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((value) => _awaitUserCreating());
    } catch (err) {
      yield UserNoExist();
    }
  }

  Stream<UserState> _mapSignInToState(SignIn event) async* {
    yield UserLoading();
    try {
      await authInstance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((value) => _awaitUserCreating());
    } catch (err) {
      yield UserNoExist();
    }
  }

  Future _awaitUserCreating() {
    return Future(() {
      firebaseInstance
          .collection('users')
          .where('id', isEqualTo: authInstance.currentUser.uid)
          .limit(1)
          .snapshots()
          .listen((data) {
        data.docChanges.forEach((element) {
          this.add(GetUser());
        });
      });
    });
  }
}
