import 'package:flutter/material.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardPreview extends DashboardState {
  final Map preview;
  final String fact;
  final int count;
  const DashboardPreview({@required this.preview, this.fact, this.count});
}
