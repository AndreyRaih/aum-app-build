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
      yield* _mapUserInitializationState();
    } else if (event is GetUser) {
      yield* _mapGetUserToState();
    } else if (event is SetUser) {
      yield* _mapSetUserToState(event);
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

  Stream<UserState> _mapGetUserToState() async* {
    try {
      AumUser user = await repository.getUserModel();
      yield UserIsDefined(user);
    } catch (err) {
      print(err);
      yield UserNoExist();
    }
  }

  Stream<UserState> _mapSetUserToState(SetUser event) async* {
    yield UserIsDefined(event.user);
  }

  Stream<UserState> _mapCreateUserToState(SignUp event) async* {
    yield UserLoading();
    try {
      await authInstance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      _awaitUserCreating();
    } catch (err) {
      yield UserNoExist();
    }
  }

  Stream<UserState> _mapSignInToState(SignIn event) async* {
    yield UserLoading();
    try {
      await authInstance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      _awaitUserCreating();
    } catch (err) {
      yield UserNoExist();
    }
  }

  void _setUserFromFirestore(source) {
    try {
      AumUser _user = AumUser(source);
      this.add(SetUser(_user));
    } catch (err) {
      print(err);
    }
  }

  void _awaitUserCreating() {
    Query firebaseRef = firebaseInstance
        .collection('users')
        .where('id', isEqualTo: authInstance.currentUser.uid)
        .limit(1);

    firebaseRef.snapshots().listen((data) {
      data.docChanges
          .forEach((changes) => _setUserFromFirestore(changes.doc.data()));
    });
  }
}
