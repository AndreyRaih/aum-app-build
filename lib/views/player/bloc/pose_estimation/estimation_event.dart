import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/pose_estimation.dart';

abstract class EstimationBlocEvent {
  const EstimationBlocEvent();
}

class EstimationCreatePointsEvent extends EstimationBlocEvent {
  final List<PoseEstimateEntity> points;
  final AsanaItem asana;
  const EstimationCreatePointsEvent(this.points, this.asana);
}
