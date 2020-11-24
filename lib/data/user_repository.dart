import 'dart:convert';

import 'package:aum_app_build/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  Future<AumUser> getUserModel(String id) {
    return http.get('$baseURL/get_user?id=$id').then((response) {
      if (response.body.length > 0) {
        return AumUser(jsonDecode(response.body));
      } else {
        throw (Error());
      }
    });
  }

  Future updateUserModel(String id, Map patch) {
    var body = json.encode({"id": id, "updates": patch});
    return http.post('$baseURL/update_user',
        headers: {"Content-Type": "application/json"}, body: body);
  }

  Future addUserSession(String id, Map<String, int> session) {
    var body = json.encode({"id": id, "session": session});
    return http.post('$baseURL/add_session_result',
        headers: {"Content-Type": "application/json"}, body: body);
  }
}
