import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/content_repository.dart';
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
  UserRepository userRepository;
  ContentRepository contentRepository = ContentRepository();

  UserBloc({this.navigation}) : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is InitializeUserSession) {
      yield* _mapUserInitializationState();
    } else if (event is SetUser) {
      yield* _mapSetUserToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is SaveUserSession) {
      yield* _mapSetUserSessionToState(event);
    } else if (event is SignUp) {
      yield* _mapCreateUserToState(event);
    } else if (event is SignIn) {
      yield* _mapSignInToState(event);
    } else if (event is ResetUser) {
      yield UserInit();
    }
  }

  Stream<UserState> _mapUserInitializationState() async* {
    yield UserInit();
    if (authInstance.currentUser != null) {
      // authInstance.signOut();
      yield UserLoading();
      userRepository = UserRepository(userId: authInstance.currentUser.uid);
      Future.wait([userRepository.getUserModel(), contentRepository.getPreview()])
          .then((results) => this.add(SetUser(results[0], personalSession: results[1])));
    } else {
      navigation.add(NavigatorPush(route: '/login'));
    }
  }

  Stream<UserState> _mapSetUserToState(SetUser event) async* {
    // Map _personalSession = event.personalSession != null ? event.personalSession : (state as UserIsDefined).personalSession;
    yield UserIsDefined(event.user, personalSession: event.personalSession);
    if (event.user.hasIntroduction) {
      navigation.add(NavigatorPush(route: '/dashboard'));
    } else {
      navigation.add(NavigatorPush(route: '/introduction'));
    }
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
    yield UserLoading();
    try {
      await userRepository.updateUserModel(event.updates);
    } catch (err) {
      print(err);
      yield UserNoExist();
    }
  }

  Stream<UserState> _mapSetUserSessionToState(SaveUserSession event) async* {
    try {
      Map<String, int> _session = {"asanaQuantity": event.asanaCount, "userRange": event.range};
      await userRepository.addUserSession(_session);
    } catch (err) {
      print(err);
    }
  }

  Stream<UserState> _mapCreateUserToState(SignUp event) async* {
    yield UserLoading();
    try {
      await authInstance.createUserWithEmailAndPassword(email: event.email, password: event.password);
      _awaitUserCreating();
    } catch (err) {
      yield UserNoExist();
    }
  }

  Stream<UserState> _mapSignInToState(SignIn event) async* {
    yield UserLoading();
    try {
      await authInstance.signInWithEmailAndPassword(email: event.email, password: event.password);
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
    firebaseRef = firebaseInstance.collection('users').where('id', isEqualTo: authInstance.currentUser.uid).limit(1);

    firebaseRef.snapshots().listen((data) {
      data.docChanges.forEach((changes) {
        _setUserFromFirestore(changes.doc.data());
      });
    });
  }
}
