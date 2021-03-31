import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const String AUM_CLOUDFUNCTIONS_API_URL = "https://us-central1-aum-app.cloudfunctions.net";

class UserRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserApiClient apiClient;

  UserRepository({String uid}) {
    String _userId = uid != null ? uid : auth.currentUser.uid;
    this.apiClient = UserApiClient(_userId);
  }

  // TODO: Add onboarding updates, progress requests

  Future createUserModel(String uid, {String avatarURL, String name}) {
    Map _userMap = {"id": uid, "name": name, "avatar": avatarURL};
    return apiClient.createUserModel(uid, _userMap);
  }

  Future updateUserModel(Map patch) => apiClient.updateUserModel(patch);

  Future completeOnboarding(String name) {
    final Map<String, Map> _updates = {
      "onboardingComplete": {name: true}
    };
    return apiClient.updateUserModel(_updates);
  }
}

class UserApiClient {
  final String baseURL = AUM_CLOUDFUNCTIONS_API_URL;
  final String userId;
  Request request = Request();

  UserApiClient(this.userId);

  Future<AumUser> createUserModel(String uid, Map profile) =>
      null; // request.post('$baseURL/update_user', {"id": userId, "updates": patch});

  Future updateUserModel(Map patch) => userId == null
      ? new ErrorHint('User ID is not defined')
      : request.post('$baseURL/update_user', {"id": userId, "updates": patch}, isJson: false);

  Future addUserSession(Map<String, int> session) => userId == null
      ? new ErrorHint('User ID is not defined')
      : request.post('$baseURL/add_session_result', {"id": userId, "session": session});

  Future setUserAsanaResult() => Future(() => true);
  // request.post('$baseURL/apply_asana_estimations', {"id": id, "estimations": result.toMap()});
}
