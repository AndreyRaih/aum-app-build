import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:flutter/material.dart';

const String AUM_CLOUDFUNCTIONS_API_URL = "https://us-central1-aum-app.cloudfunctions.net";

class UserRepository {
  final UserApiClient apiClient = UserApiClient();

  String userId;

  UserRepository();

  void setUserId(String id) => userId = id;

  Future updateUserModel(Map patch) => apiClient.updateUserModel(userId, patch);

  Future addUserSession(Map<String, int> session) => apiClient.addUserSession(userId, session);

  Future completeOnboarding(String name) {
    final Map<String, Map> _updates = {
      "onboardingComplete": {name: true}
    };
    print('user onboarding sesstion: $_updates');
    return apiClient.updateUserModel(userId, _updates);
  }

  Future sendAsanaResult(AsanaEstimationResult result) => apiClient.setUserAsanaResult(userId, result);
}

class UserApiClient {
  final String baseURL = AUM_CLOUDFUNCTIONS_API_URL;
  Request request = Request();

  Future updateUserModel(String id, Map patch) => id == null
      ? new ErrorHint('User ID is not defined')
      : request.post('$baseURL/update_user', {"id": id, "updates": patch});

  Future addUserSession(String id, Map<String, int> session) => id == null
      ? new ErrorHint('User ID is not defined')
      : request.post('$baseURL/add_session_result', {"id": id, "session": session});

  Future setUserAsanaResult(String id, AsanaEstimationResult result) =>
      request.post('$baseURL/apply_asana_estimations', {"id": id, "estimations": result.toMap()});
}
