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
        name: 'Sphynx',
        audio:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_1%2Fsphynx_lying_forward_1%2Fmale_voice.mp3?alt=media&token=bc1b49e3-6fed-4371-a80f-07c0f34d1c08',
        url:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/lying_forward_1%2Fsphynx_lying_forward_1.mp4?alt=media&token=9170c49c-b0c0-4811-b0cd-3877eda3f01d',
      ),
      AsanaVideoPart(
        name: 'Plank',
        isCheck: false,
        audio:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fplank-lying_forward_2.%2Fmale_voice.mp3?alt=media&token=7221b054-77bf-45e7-9f95-f20a6bcd0019',
        url:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/lying_forward_2%2Fplank-lying_forward_2.mp4?alt=media&token=543c2c85-d4cf-4153-b09f-37cb9e3d6afa',
      ),
      AsanaVideoPart(
        name: 'Dhanurasana',
        isCheck: true,
        audio:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fdhanurasana-lying_forward_2%2Fmale_voice.mp3?alt=media&token=147fa108-647f-4a90-bbd7-ac8dbe737c32',
        url:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/lying_forward_2%2Fdhanurasana-lying_forward_2.mp4?alt=media&token=27167d29-96c3-4c62-a790-8af7fae5f879',
      )
    ];
    return Future.delayed(const Duration(seconds: 2)).then((value) => _result);
  }
}
