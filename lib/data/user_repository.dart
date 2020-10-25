import 'dart:convert';

import 'package:aum_app_build/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final UserApiClient apiClient = UserApiClient();
  final String userId;
  UserRepository({@required this.userId});
  Future<AumUser> getUserModel() => apiClient.getUserModel(userId);

  Future<AumUser> updateUserModel(Map<String, dynamic> patch) =>
      apiClient.updateUserModel(userId, patch);
}

class UserApiClient {
  final String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';
  Future<AumUser> getUserModel(String id) {
    return http.get('$baseURL/get_user?id=$id').then((response) {
      return AumUser(jsonDecode(response.body));
    });
  }

  Future updateUserModel(String id, Map<String, dynamic> patch) =>
      http.post('$baseURL/update_user', body: {'id': id, 'updates': patch});
}
