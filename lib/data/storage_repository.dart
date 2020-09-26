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
          name: 'Mountain pose',
          url:
              'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Fstanding-balances_1.mp4?alt=media&token=0f146711-87cf-4552-9b8d-192358d53c4e'),
      AsanaVideoPart(
          name: 'Tree pose',
          url:
              'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Ftree-balances_1.mp4?alt=media&token=82dd8761-39a8-46bb-809e-effa2030e433'),
      AsanaVideoPart(
          name: 'Warrior pose left',
          url:
              'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Fwarrior_left-balances_1.mp4?alt=media&token=8f295bbd-d364-4992-aeaa-c8ab808ba7e6'),
      AsanaVideoPart(
          name: 'Warrior pose right',
          url:
              'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Fwarrior_right-balances_1.mp4?alt=media&token=6473e2c8-b52b-4087-aec0-9ef9f21228fe',
          isCheck: true)
    ];
    return Future.delayed(const Duration(seconds: 2)).then((value) => _result);
  }
}
