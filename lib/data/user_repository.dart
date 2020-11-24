import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final UserApiClient apiClient = UserApiClient();
  final String userId;
  UserRepository({@required this.userId});
  Future<AumUser> getUserModel() => apiClient.getUserModel(userId);

  Future updateUserModel(Map patch) => apiClient.updateUserModel(userId, patch);

  Future addUserSession(Map<String, int> session) =>
      apiClient.addUserSession(userId, session);
}

class UserApiClient {
  final String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';
  Request request = Request();
  Future<AumUser> getUserModel(String id) =>
      request.get('$baseURL/get_user?id=$id').then((value) => AumUser(value));

  Future updateUserModel(String id, Map patch) =>
      request.post('$baseURL/update_user', {"id": id, "updates": patch});

  Future addUserSession(String id, Map<String, int> session) => request
      .post('$baseURL/add_session_result', {"id": id, "session": session});
}
