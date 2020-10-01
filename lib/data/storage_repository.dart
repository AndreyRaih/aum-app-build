import 'dart:async';

import 'package:aum_app_build/data/models/asana.dart';

class StorageRepository {
  final StorageApiClient storageApiClient = StorageApiClient();
  Future<List<AsanaVideoPart>> getAsanaQueue() async {
    return storageApiClient.getPersonalQueue();
  }
}

class StorageApiClient {
  String baseURL;
  Future<List<AsanaVideoPart>> getPersonalQueue() {
    List<AsanaVideoPart> _result = [
      AsanaVideoPart(
        name: 'Dhanurasana',
        audio:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fdhanurasana-lying_forward_2%2Fmale_voice.mp3?alt=media&token=147fa108-647f-4a90-bbd7-ac8dbe737c32',
        url:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/lying_forward_2%2Fdhanurasana-lying_forward_2.mp4?alt=media&token=27167d29-96c3-4c62-a790-8af7fae5f879',
      )
    ];
    return Future.delayed(const Duration(seconds: 2)).then((value) => _result);
  }
}
