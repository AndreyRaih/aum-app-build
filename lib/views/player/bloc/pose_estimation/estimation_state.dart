import 'package:aum_app_build/utils/pose_estimation.dart';

abstract class EstimationBlocState {
  const EstimationBlocState();
}

class EstimationActive extends EstimationBlocState {
  final List<PoseEstimateEntity> points;
  const EstimationActive(this.points);
}

class EstimationAwait extends EstimationBlocState {
  const EstimationAwait();
}
