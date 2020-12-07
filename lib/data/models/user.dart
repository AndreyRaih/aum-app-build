import 'package:aum_app_build/utils/data.dart';

class AumUser {
  String uid;
  String name;
  Map levels;
  List recentResults;
  List sessions;
  Map onboardingComplete;

  AumUser(data) {
    var utils = DataUtils(data);
    this.uid = utils.fromData("uid");
    this.name = utils.fromData("name");
    this.levels = utils.fromData("levels");
    this.recentResults = utils.fromData("recentResults");
    this.sessions = utils.fromData("sessions");
    this.onboardingComplete = utils.fromData("onboardingComplete");
  }
}
