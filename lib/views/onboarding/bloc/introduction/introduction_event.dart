abstract class IntroductionEvent {
  const IntroductionEvent();
}

class IntroductionAwait extends IntroductionEvent {
  const IntroductionAwait();
}

class IntroductionNext extends IntroductionEvent {
  final Map updates;
  const IntroductionNext({this.updates});
}

class IntroductionSkip extends IntroductionEvent {
  const IntroductionSkip();
}
