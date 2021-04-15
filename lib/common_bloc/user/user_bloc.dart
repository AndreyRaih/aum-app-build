import 'dart:async';

import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final NavigatorCubit navigation;

  UserRepository repository;
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
    } else if (event is SetUserModel) {
      yield* _mapSetUserModelToState(event);
    } else if (event is UpdateUserModel) {
      yield* _mapUpdateUserModelToState(event);
    } else if (event is SetUserError) {
      yield UserFailure();
    }
  }

  Stream<UserState> _mapStartUserSessionToState() async* {
    // authInstance.signOut();
    if (authInstance.currentUser != null) {
      sessionListener = this.listen((state) {
        print('listened data: $state');
        if (state is UserSuccess) {
          navigation.navigatorPush(DASHBOARD_ROUTE_NAME);
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
    navigation.navigatorPush(LOGIN_ROUTE_NAME);
  }

  Stream<UserState> _mapSetUserModelToState(SetUserModel event) async* {
    print('user setted: ${event.user}');
    yield UserSuccess(event.user);
  }

  Stream<UserState> _mapUpdateUserModelToState(UpdateUserModel event) async* {
    yield UserLoading();
    try {
      AumUser _patchedModel = await repository.updateUserModel(event.updates);
      yield UserSuccess(_patchedModel);
    } catch (err) {
      print(err);
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
}
