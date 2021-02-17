import 'dart:async';
import 'dart:io';

import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final NavigatorBloc navigation;

  final UserRepository userRepository = UserRepository();
  final ContentRepository contentRepository = ContentRepository();

  StreamSubscription sessionListener;
  Query firebaseObserveRef;

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
    } else if (event is UserOnboardingRouteHook) {
      yield* _mapUserOnboardingRouteHookToState(event);
    } else if (event is CompleteUserOnboarding) {
      yield* _mapCompleteUserOnboardingToState(event);
    } else if (event is SaveUserResult) {
      yield* _mapSaveUserResultToState(event);
    } else if (event is UserSignUp) {
      yield* _mapUserSignUpToState(event);
    } else if (event is UserSignIn) {
      yield* _mapUserSignInToState(event);
    } else if (event is SetUserModel) {
      yield* _mapSetUserModelToState(event);
    } else if (event is SetUserError) {
      yield UserFailure();
    }
  }

  Stream<UserState> _mapStartUserSessionToState() async* {
    if (authInstance.currentUser != null) {
      userRepository.setUserId(authInstance.currentUser.uid);
      sessionListener = this.listen((state) {
        print('listened data: $state');
        if (state is UserSuccess) {
          _getScreenAfterInitital(state.user);
          sessionListener.cancel();
        }
        if (state is UserFailure) {
          this.add(EndUserSession());
        }
      });
    } else {
      this.add(EndUserSession());
    }
  }

  Stream<UserState> _mapEndUserSessionToState() async* {
    sessionListener?.cancel();
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

  Stream<UserState> _mapUserOnboardingRouteHookToState(UserOnboardingRouteHook event) async* {
    final AumUserOnboarding onboardingState = (state as UserSuccess).user.onboardingComplete;
    navigation.add(NavigatorPush(route: event.route, arguments: event.arguments));
    switch (event.onboardingTarget) {
      case UserOnboardingTarget.concept:
        if (!onboardingState.concept) {
          navigation.add(NavigatorPush(route: CONCEPT_ONBOARDING_ROUTE_NAME));
        }
        break;
      case UserOnboardingTarget.player:
        if (!onboardingState.player) {
          navigation.add(NavigatorPush(route: PLAYER_ONBOARDING_ROUTE_NAME));
        }
        break;
    }
  }

  Stream<UserState> _mapCompleteUserOnboardingToState(CompleteUserOnboarding event) async* {
    yield UserLoading();
    try {
      String _name;
      switch (event.name) {
        case UserOnboardingTarget.concept:
          _name = "concept";
          break;
        case UserOnboardingTarget.player:
          _name = "player";
          break;
      }
      await userRepository.completeOnboarding(_name);
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
      AumUserPractice _personalSession;
      String _avatar;
      if (_existModel != null) {
        if (_existModel.personalSession != null) {
          _personalSession = _existModel.personalSession;
        }
        if (_existModel.avatarUrl != null) {
          _avatar = _existModel.avatarUrl;
        }
        print('get new session: $_personalSession');
      } else {
        String _storageLink = '$FIRESTORAGE_IMAGE_BASKET_NAME/${event.user.id}/avatar.jpeg';
        Map _practiceResponse = await contentRepository.getPractice(event.user.id);
        _personalSession = AumUserPractice(_practiceResponse);
        try {
          _avatar = await contentRepository.getStorageDownloadURL(_storageLink);
        } catch (err) {
          print(err);
          _avatar = DEFAULT_AVATAR_IMG;
        }
        print('get exist: $_personalSession');
      }
      yield UserSuccess(event.user, personalSession: _personalSession, avatarUrl: _avatar);
    } catch (error) {
      print(error);
      this.add(SetUserError());
    }
  }

  Stream<UserState> _mapUserSignUpToState(UserSignUp event) async* {
    yield UserLoading();
    try {
      final Map _userUpdates = {"name": event.data.name};
      User _user = await authInstance
          .createUserWithEmailAndPassword(email: event.data.email, password: event.data.password)
          .then((credentials) => credentials.user);
      await _awaitUserCreation(_user.uid);
      this.add(StartUserSession());
      this.add(UpdateUserModel(_userUpdates));
      if (event.data.avatar != null) {
        _uploadAvatar(event.data.avatar, _user.uid);
      }
    } catch (err) {
      print(err);
      this.add(SetUserError());
    }
  }

  Stream<UserState> _mapUserSignInToState(UserSignIn event) async* {
    yield UserLoading();
    try {
      await authInstance.signInWithEmailAndPassword(email: event.data.email, password: event.data.password);
      this.add(StartUserSession());
    } catch (err) {
      print(err);
      this.add(SetUserError());
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

  Query _buildUserObserver(String uid) =>
      FirebaseFirestore.instance.collection('users').where('id', isEqualTo: uid).limit(1);

  void _subscribeUserChanges(String uid) {
    firebaseObserveRef = _buildUserObserver(uid);
    firebaseObserveRef.snapshots().listen((QuerySnapshot data) {
      if (data.size == 0) {
        print("user cannot find");
        this.add(SetUserError());
      }
      data.docChanges.forEach((updates) {
        print('user changes: ${updates.doc.data()}');
        AumUser _user = AumUser.fromJson(updates.doc.data());
        this.add(SetUserModel(_user));
      });
    });
  }

  void _describeUserChanges() {
    firebaseObserveRef = null;
  }

  Future _awaitUserCreation(String uid) {
    Completer _completer = new Completer();
    Query _userAwaitObserve = _buildUserObserver(uid);
    _userAwaitObserve.snapshots().listen((QuerySnapshot data) {
      print('waiting: $data; size:${data.size}');
      if (data.size > 0 && !_completer.isCompleted) {
        _completer.complete();
        _userAwaitObserve = null;
      }
    });
    return _completer.future;
  }

  void _uploadAvatar(File avatar, String id) {
    String _filename = 'avatar.jpeg';
    ContentRepository().uploadImage(imageToUpload: avatar, filename: _filename, id: id);
  }

  void _getScreenAfterInitital(AumUser user) =>
      this.add(UserOnboardingRouteHook(onboardingTarget: UserOnboardingTarget.concept, route: DASHBOARD_ROUTE_NAME));
}
