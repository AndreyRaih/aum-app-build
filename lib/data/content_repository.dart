import 'dart:io';

import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentRepository {
  final ContentApiClient apiClient = ContentApiClient();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future getQueue(List blocks) => apiClient.getPersonalQueue(blocks);

  Future getPractice(String id) => apiClient.getPractice(id);

  Future getFact() => apiClient.getFact();

  Future<String> getStorageDownloadURL(String storageURL) => storage.refFromURL(storageURL).getDownloadURL();

  Future uploadImage({
    @required File imageToUpload,
    @required String filename,
  }) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instanceFor(bucket: FIRESTORAGE_IMAGE_BASKET_NAME).ref().child('${authInstance.currentUser.uid}/$filename');

    await firebaseStorageRef.putFile(imageToUpload);
  }
}

class ContentApiClient {
  String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';
  Request request = Request();

  Future getPersonalQueue(List blocks) => request.post('$baseURL/get_asana_queue', {"blocks": blocks.map((e) => e.toString()).toList()});

  Future getPractice(String id) => request.get('$baseURL/get_practice_preview?id=$id');

  Future getFact() => request.get('$baseURL/get_fact', isJson: false);
}
