import 'dart:io';

import 'package:aum_app_build/utils/requests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentRepository {
  final ContentApiClient apiClient = ContentApiClient();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future getQueue() => apiClient.getPersonalQueue();

  Future getPreview() => apiClient.getPreview();

  Future getFact() => apiClient.getFact();

  Future<String> getStorageDownloadURL(String storageURL) => storage.refFromURL(storageURL).getDownloadURL();

  Future uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {
    final Reference firebaseStorageRef = FirebaseStorage.instanceFor(bucket: 'gs://aum-app-images')
        .ref()
        .child('${authInstance.currentUser.uid}/$title-${DateTime.now().millisecondsSinceEpoch.toString()}');

    await firebaseStorageRef.putFile(imageToUpload);
  }
}

class ContentApiClient {
  String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';
  Request request = Request();

  Future getPersonalQueue() => request.get('$baseURL/get_asana_queue');

  Future getPreview() => request.get('$baseURL/get_practice_preview');

  Future getFact() => request.get('$baseURL/get_fact', isJson: false);
}
