import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final NavigatorBloc navigation;
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  Query firebaseRef;
  FirebaseAuth authInstance = FirebaseAuth.instance;
  UserRepository repository;

  UserBloc({this.navigation}) : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is InitializeUserSession) {
      yield* _mapUserInitializationState();
    } else if (event is SetUser) {
      yield* _mapSetUserToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is SignUp) {
      yield* _mapCreateUserToState(event);
    } else if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<UserState> _mapUserInitializationState() async* {
    yield UserLoading();
    if (authInstance.currentUser != null) {
      repository = UserRepository(userId: authInstance.currentUser.uid);
      AumUser user = await repository.getUserModel();
      this.add(SetUser(user));
      navigation.add(NavigatorPush(route: '/introduction'));
    } else {
      navigation.add(NavigatorPush(route: '/login'));
    }
  }

  Stream<UserState> _mapSetUserToState(SetUser event) async* {
    yield UserIsDefined(event.user);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
    yield UserLoading();
    try {
      _awaitUserCreating();
      await repository.updateUserModel(event.updates);
    } catch (err) {
      print(err);
      yield UserNoExist();
    }
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
      firebaseRef = null;
    } catch (err) {
      print(err);
    }
  }

  void _awaitUserCreating() {
    firebaseRef = firebaseInstance
        .collection('users')
        .where('id', isEqualTo: authInstance.currentUser.uid)
        .limit(1);

    firebaseRef.snapshots().listen((data) {
      data.docChanges.forEach((changes) {
        _setUserFromFirestore(changes.doc.data());
      });
    });
  }
}
