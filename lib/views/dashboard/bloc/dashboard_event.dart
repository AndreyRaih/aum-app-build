import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';

abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardInitialise extends DashboardEvent {
  const DashboardInitialise();
}

class DashboardGetTags extends DashboardEvent {
  const DashboardGetTags();
}

class DashboardSetTags extends DashboardEvent {
  final List<String> tags;
  const DashboardSetTags(this.tags);
}

class DashboardSelectTag extends DashboardEvent {
  final String tag;
  const DashboardSelectTag(this.tag);
}

class DashboardGetFeed extends DashboardEvent {
  final String tagByFeed;
  const DashboardGetFeed(this.tagByFeed);
}

class DashboardSetFeed extends DashboardEvent {
  final DashboardFeed feed;
  const DashboardSetFeed(this.feed);
}
