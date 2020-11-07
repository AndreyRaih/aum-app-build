abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardGetPreview extends DashboardEvent {
  const DashboardGetPreview();
}

class DashboardUpdateUsersCount extends DashboardEvent {
  final int count;
  const DashboardUpdateUsersCount({this.count});
}
