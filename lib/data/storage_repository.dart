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
        audio: [
          {
            'type': 'male',
            'url':
                'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fdhanurasana-lying_forward_2%2Fmale_voice.mp3?alt=media&token=147fa108-647f-4a90-bbd7-ac8dbe737c32',
            'complexity': 'full'
          },
          {
            'type': 'male',
            'url':
                'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fdhanurasana-lying_forward_2%2Fmale_voice_short.mp3?alt=media&token=18d33b31-bcdb-4d9e-9785-d82dcee3a3b8',
            'complexity': 'short'
          },
          {
            'type': 'female',
            'url':
                'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fdhanurasana-lying_forward_2%2Ffemale_voice_1.mp3?alt=media&token=d46d32eb-be24-4e19-87ca-6bd0301ba762',
            'complexity': 'full'
          },
          {
            'type': 'female',
            'url':
                'https://firebasestorage.googleapis.com/v0/b/aum-app-audio/o/lying_forward_2%2Fdhanurasana-lying_forward_2%2Ffemale_voice_1_short.mp3?alt=media&token=c5b78b95-379d-4a20-8ed5-88ae16bae8bf',
            'complexity': 'short'
          }
        ],
        url:
            'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/lying_forward_2%2Fdhanurasana-lying_forward_2.mp4?alt=media&token=27167d29-96c3-4c62-a790-8af7fae5f879',
      )
    ];
    return Future.delayed(const Duration(seconds: 2)).then((value) => _result);
  }
}
