import "dart:io";

import "package:aum_app_build/data/constants.dart";
import "package:aum_app_build/data/models/asana.dart";
import "package:aum_app_build/data/models/practice.dart";
import "package:aum_app_build/utils/requests.dart";
import "package:flutter/material.dart";
import "package:firebase_storage/firebase_storage.dart";

class ContentRepository {
  final ContentApiClient apiClient = ContentApiClient();
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Feed

  Future<List<String>> getTags() => apiClient.getTags();

  Future<List<AumUserPractice>> getFeed(String id, String requestedTag) => apiClient.getFeed(id, requestedTag);

  // Content

  Future<List<AsanaItem>> getVideoplayerContent(List blocks) async {
    List _raw = await apiClient.getMediaSources(blocks);
    List _result = [];
    _raw
        .map((element) => element["value"])
        .where((element) => element.length > 0)
        .forEach((element) => _result..addAll(element));
    return _result.map((element) => AsanaItem.fromJson(element)).toList();
  }

  // Firestorage

  Future<String> getStorageDownloadURL(String storageURL) => storage.refFromURL(storageURL).getDownloadURL();

  Future uploadImage({@required File imageToUpload, @required String filename, @required String id}) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instanceFor(bucket: FIRESTORAGE_IMAGE_BASKET_NAME).ref().child("$id/$filename");

    await firebaseStorageRef.putFile(imageToUpload);
  }
}

class ContentApiClient {
  String baseURL = "https://us-central1-aum-app.cloudfunctions.net";
  Request request = Request();

  Future getMediaSources(List blocks) =>
      request.post("$baseURL/get_asana_queue", {"blocks": blocks.map((e) => e.toString()).toList()});

  Future<List<String>> getTags() => Future(() =>
      ["Mind", "Balance", "Hatha yoga", "Mindfulness movings", "Ashtanga challenge", "Strong, deep and again strong"]);
  // request.get("$baseURL/get_fact", isJson: false);

  Future<List<AumUserPractice>> getFeed(String id, String tag) => Future(() => [
        AumUserPractice({
          "name": "Stress relief",
          "description":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
          "accents": ["balance", "Stretching"],
          "time": 35,
          "cal": 235,
          "benefits": ["First benefit", "Second benefit", "Third benefit"],
          "userQueue": [],
          "descriptionImg": "https://data.whicdn.com/images/174118433/original.jpg",
          "isMain": true
        }),
        AumUserPractice({
          "name": "Ashtanga flow #2",
          "description":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
          "accents": ["Anaerobic", "arms"],
          "time": 35,
          "cal": 235,
          "benefits": ["First benefit", "Second benefit", "Third benefit"],
          "userQueue": [],
          "descriptionImg": "https://i.pinimg.com/originals/f6/d5/1b/f6d51b14701d1c145f46231205e44b0c.jpg",
          "isMain": true
        }),
        AumUserPractice({
          "name": "Strong body, clear mind",
          "description":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
          "accents": ["Arms", "Abs"],
          "time": 25,
          "cal": 320,
          "benefits": ["First benefit", "Second benefit", "Third benefit"],
          "userQueue": [],
          "descriptionImg": "https://img3.goodfon.ru/wallpaper/nbig/7/a9/equilibrium-yoga-man.jpg",
          "isMain": false
        }),
        AumUserPractice({
          "name": "Fast, long and silence",
          "description":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
          "accents": ["Stratching"],
          "time": 35,
          "cal": 235,
          "benefits": ["First benefit", "Second benefit", "Third benefit"],
          "userQueue": [],
          "descriptionImg":
              "https://avatars.mds.yandex.net/get-zen_doc/203431/pub_5be17356c97a4100ab2cc58c_5be1780a5bffdd00aa3c9fa9/scale_1200",
          "isMain": false
        }),
        AumUserPractice({
          "name": "Daily routine",
          "description":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
          "accents": ["Abs", "arms"],
          "time": 40,
          "cal": 330,
          "benefits": ["First benefit", "Second benefit", "Third benefit"],
          "userQueue": [],
          "descriptionImg": "https://data.whicdn.com/images/329662373/original.jpg",
          "isMain": false
        })
      ]);
  //request.get("$baseURL/get_practice_preview?id=$id&tag=$tag");
}
