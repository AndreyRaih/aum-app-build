abstract class DashboardState {
  const DashboardState();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardPreview extends DashboardState {
  final Map preview;
  const DashboardPreview({this.preview});
}
