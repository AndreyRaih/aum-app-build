import 'package:aum_app_build/data/models/practice.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoadingError extends DashboardState {
  const DashboardLoadingError();
}

class DashboardTagsLoading extends DashboardState {
  const DashboardTagsLoading();
}

class DashboardFeedLoading extends DashboardState {
  const DashboardFeedLoading();
}

class DashboardPreview extends DashboardState {
  final List<String> tags;
  final String selectedTag;
  final DashboardFeed feed;

  const DashboardPreview({this.tags, this.selectedTag, this.feed});

  List<AumUserPractice> get mainFeed => feed.main;
  List<AumUserPractice> get additionalFeed => feed.additional;
  DashboardViews get currentView => feed != null ? DashboardViews.feed : DashboardViews.initial;
}

enum DashboardViews { initial, feed }

class DashboardFeed {
  List<AumUserPractice> main;
  List<AumUserPractice> additional;

  DashboardFeed(List<AumUserPractice> content) {
    this.main = content.where((element) => element.isMain).toList();
    this.additional = content.where((element) => !element.isMain).toList();
  }
}
