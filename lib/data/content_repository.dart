import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class ContentRepository {
  final ContentApiClient apiClient = ContentApiClient();
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<List<dynamic>> getAsanaQueue() => apiClient.getPersonalQueue();

  Future getPreview() => apiClient.getPreview();

  Future getFact() => apiClient.getFact();

  Future<String> getStorageDownloadURL(String storageURL) =>
      storage.refFromURL(storageURL).getDownloadURL();
}

class ContentApiClient {
  String baseURL = 'https://us-central1-aum-app.cloudfunctions.net';

  Future<List<dynamic>> getPersonalQueue() {
    return http.get('$baseURL/get_asana_queue').then((response) {
      List _rawQueue = jsonDecode(response.body);
      List _preparedQueue = _rawQueue
          .map((elem) => elem["value"])
          .where((element) => element.length > 0)
          .toList();
      List _result = [];
      _preparedQueue.forEach((_part) => _result.addAll(_part));
      return _result;
    });
  }

  Future getPreview() {
    return http
        .get('$baseURL/get_practice_preview')
        .then((response) => jsonDecode(response.body));
  }

  Future getFact() {
    return http.get('$baseURL/get_fact').then((response) => response.body);
  }
}
