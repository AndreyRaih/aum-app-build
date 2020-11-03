abstract class IntroductionEvent {
  const IntroductionEvent();
}

class IntroductionAwait extends IntroductionEvent {
  const IntroductionAwait();
}

class IntroductionNext extends IntroductionEvent {
  final Map<String, String> updates;
  const IntroductionNext({this.updates});
}

class SetIntroductionStage extends IntroductionEvent {
  final int stage;
  const SetIntroductionStage({this.stage = 0});
}

class IntroductionSkip extends IntroductionEvent {
  const IntroductionSkip();
}
