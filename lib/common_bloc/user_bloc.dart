import 'dart:async';

import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/models/routes.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final NavigatorBloc navigation;

  StreamSubscription sessionListener;
  Query firebaseObserveRef;

  UserRepository userRepository;
  ContentRepository contentRepository = ContentRepository();

  UserBloc({@required this.navigation}) : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    _observeUserModel();
    if (event is StartUserSession) {
      yield* _mapStartUserSessionToState();
    } else if (event is EndUserSession) {
      yield* _mapEndUserSessionToState();
    } else if (event is ResetUserSession) {
      yield* _mapResetUserSessionToState();
    } else if (event is UpdateUserModel) {
      yield* _mapUpdateUserToState(event);
    } else if (event is SaveUserResult) {
      yield* _mapSaveUserResultToState(event);
    } else if (event is SetUserModel) {
      yield* _mapSetUserModelToState(event);
    } else if (event is UserSignUp) {
      yield* _mapUserSignUpToState(event);
    } else if (event is UserSignIn) {
      yield* _mapUserSignInToState(event);
    }
  }

  Stream<UserState> _mapStartUserSessionToState() async* {
    if (authInstance.currentUser != null) {
      userRepository = UserRepository(userId: authInstance.currentUser.uid);
      sessionListener = this.listen((state) {
        print('listened data: $state');
        if (state is UserSuccess) {
          _getScreenAfterInitital(state.user);
          sessionListener.cancel();
        }
      });
    } else {
      this.add(EndUserSession());
    }
  }

  Stream<UserState> _mapEndUserSessionToState() async* {
    authInstance.signOut();
    navigation.add(NavigatorPush(route: LOGIN_ROUTE_NAME));
    this.add(ResetUserSession());
  }

  Stream<UserState> _mapResetUserSessionToState() async* {
    yield UserInit();
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUserModel event) async* {
    try {
      await userRepository.updateUserModel(event.updates);
    } catch (err) {
      print(err);
    }
  }

  Stream<UserState> _mapSaveUserResultToState(SaveUserResult event) async* {
    Map<String, int> _session = {"asanaQuantity": event.asanaCount, "userRange": event.range};
    try {
      await userRepository.addUserSession(_session);
    } catch (err) {
      print(err);
    }
  }

  Stream<UserState> _mapSetUserModelToState(SetUserModel event) async* {
    print('user setted: ${event.user}');
    try {
      UserSuccess _existModel = state is UserSuccess ? (state as UserSuccess) : null;
      Map _personalSession;
      if (_existModel == null && event.personalSession == null) {
        _personalSession = await contentRepository.getPreview();
        print('get new session: $_personalSession');
      } else {
        _personalSession = event.personalSession != null ? event.personalSession : _existModel.personalSession;
        print('get exist: $_personalSession');
      }
      yield UserSuccess(event.user, personalSession: _personalSession);
    } catch (error) {
      print(error);
      yield UserFailure();
    }
  }

  Stream<UserState> _mapUserSignUpToState(UserSignUp event) async* {
    yield UserLoading();
    try {
      await authInstance.createUserWithEmailAndPassword(email: event.email, password: event.password);
      this.add(StartUserSession());
    } catch (err) {
      print(err);
      yield UserFailure();
    }
  }

  Stream<UserState> _mapUserSignInToState(UserSignIn event) async* {
    yield UserLoading();
    try {
      await authInstance.signInWithEmailAndPassword(email: event.email, password: event.password);
      this.add(StartUserSession());
    } catch (err) {
      print(err);
      yield UserFailure();
    }
  }

  void _observeUserModel() {
    print('start user session');
    bool _isAuth = authInstance.currentUser != null;
    if (_isAuth && firebaseObserveRef == null) {
      print('user observer: subscribe');
      _subscribeUserChanges(authInstance.currentUser.uid);
    } else if (!_isAuth && firebaseObserveRef != null) {
      print('user observer: describe');
      _describeUserChanges();
    }
  }

  void _subscribeUserChanges(String uid) {
    firebaseObserveRef = FirebaseFirestore.instance.collection('users').where('id', isEqualTo: uid).limit(1);
    firebaseObserveRef.snapshots().listen((data) {
      data.docChanges.forEach((updates) {
        print('user changes: ${updates.doc.data()}');
        AumUser _user = AumUser(updates.doc.data());
        this.add(SetUserModel(_user));
      });
    });
  }

  void _describeUserChanges() {
    firebaseObserveRef = null;
  }

  void _getScreenAfterInitital(AumUser user) {
    if (!user.hasIntroduction) {
      navigation.add(NavigatorPush(route: DASHBOARD_ROUTE_NAME));
    } else {
      navigation.add(NavigatorPush(route: INTRODUCTION_ONBOARDING_ROUTE_NAME));
    }
  }
}
