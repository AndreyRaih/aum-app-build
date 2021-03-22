import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/pose_estimation.dart';

const List<String> UNNECESSARY_POINTS = ['leftEar', 'rightEar', 'leftEye', 'rightEye', 'nose'];

abstract class EstimationBlocEvent {
  const EstimationBlocEvent();
}

class EstimationCreatePointsEvent extends EstimationBlocEvent {
  final List<PoseEstimateEntity> rawPoints;
  final AsanaItem asana;
  const EstimationCreatePointsEvent(this.rawPoints, this.asana);

  List<PoseEstimateEntity> get points =>
      rawPoints.where((element) => !UNNECESSARY_POINTS.contains(element.part)).toList();
}
