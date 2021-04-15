import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/utils/requests.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String AUM_CLOUDFUNCTIONS_API_URL = "https://us-central1-aum-app.cloudfunctions.net";

class UserRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserApiClient apiClient;

  UserRepository({String uid}) {
    String _userId = uid != null ? uid : auth.currentUser.uid;
    this.apiClient = UserApiClient(_userId);
  }

  Future updateUserModel(AumUserUpdatesModel updates) {
    return apiClient.updateUserModel(updates.toMap());
  }

  Future onboardingComplete(String name) {
    return apiClient.completeOnboarding(name);
  }

  Future getWeeklyStatistic() => apiClient.getUserWeeklyStatistic();

  Future getLastAsanasNotes() => apiClient.getUserLastAsanasNotes();

  Future getDetailsForAsanaNote() => apiClient.getDetailsForAsanaNote();

  Future getFeedbackQuestions() => apiClient.setFeedback();
}

class UserApiClient {
  final String baseURL = AUM_CLOUDFUNCTIONS_API_URL;
  final String userId;
  Request request = Request();

  UserApiClient(this.userId);

  Future<AumUser> updateUserModel(Map data) => Future(() => null);

  Future completeOnboarding(String name) => Future(() => null);

  Future getUserWeeklyStatistic() => Future(() => null);

  Future getUserLastAsanasNotes() => Future(() => null);

  Future getDetailsForAsanaNote() => Future(() => null);

  Future setUserResult() => Future(() => null);

  Future setFeedback() => Future(() => null);
}
