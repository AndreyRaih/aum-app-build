import 'dart:io';

import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentRepository {
  final ContentApiClient apiClient = ContentApiClient();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<AsanaItem>> getQueue(List blocks) async {
    List _raw = await apiClient.getPersonalQueue(blocks);
    List _result = [];
    _raw
        .map((element) => element["value"])
        .where((element) => element.length > 0)
        .forEach((element) => _result..addAll(element));
    return _result.map((element) => AsanaItem.fromJson(element)).toList();
  }

  Future getPractice(String id) => apiClient.getPractice(id);

  Future getFact() => apiClient.getFact();

  Future<String> getStorageDownloadURL(String storageURL) => storage.refFromURL(storageURL).getDownloadURL();

  Future uploadImage({@required File imageToUpload, @required String filename, @required String id}) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instanceFor(bucket: FIRESTORAGE_IMAGE_BASKET_NAME).ref().child('$id/$filename');

    await firebaseStorageRef.putFile(imageToUpload);
  }
}

class ContentApiClient {
  String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';
  Request request = Request();

  Future getPersonalQueue(List blocks) =>
      request.post('$baseURL/get_asana_queue', {"blocks": blocks.map((e) => e.toString()).toList()});

  Future getPractice(String id) => request.get('$baseURL/get_practice_preview?id=$id');

  Future getFact() => request.get('$baseURL/get_fact', isJson: false);
}
