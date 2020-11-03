abstract class IntroductionState {
  const IntroductionState();
}

class IntroductionStage extends IntroductionState {
  final int stage;
  const IntroductionStage({this.stage = 0});

  int get currentStage => this.stage;
}

class IntroductionWaiting extends IntroductionState {
  const IntroductionWaiting();
}
