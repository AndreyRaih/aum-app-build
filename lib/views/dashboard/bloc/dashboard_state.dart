abstract class DashboardState {
  const DashboardState();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardPreview extends DashboardState {
  final String fact;
  final int count;
  const DashboardPreview({this.fact, this.count});
}
