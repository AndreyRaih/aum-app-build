import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final UserApiClient apiClient = UserApiClient();

  String userId;

  UserRepository();

  void setUserId(String id) => userId = id;

  Future<AumUser> getUserModel() => apiClient.getUserModel(userId);

  Future updateUserModel(Map patch) => apiClient.updateUserModel(userId, patch);

  Future addUserSession(Map<String, int> session) => apiClient.addUserSession(userId, session);

  Future completeOnboarding(String name) {
    final Map<String, Map> _updates = {
      "onboardingComplete": {name: true}
    };
    print('user onboarding sesstion: $_updates');
    return apiClient.updateUserModel(userId, _updates);
  }
}

class UserApiClient {
  final String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';
  Request request = Request();
  Future<AumUser> getUserModel(String id) =>
      id == null ? new ErrorHint('User ID is not defined') : request.get('$baseURL/get_user?id=$id').then((value) => AumUser(value));

  Future updateUserModel(String id, Map patch) =>
      id == null ? new ErrorHint('User ID is not defined') : request.post('$baseURL/update_user', {"id": id, "updates": patch});

  Future addUserSession(String id, Map<String, int> session) =>
      id == null ? new ErrorHint('User ID is not defined') : request.post('$baseURL/add_session_result', {"id": id, "session": session});
}
