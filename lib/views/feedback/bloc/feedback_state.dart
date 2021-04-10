abstract class FeedbackState {
  const FeedbackState();
}

class FeedbackIsLoading extends FeedbackState {
  const FeedbackIsLoading();
}

class FeedbackSuccess extends FeedbackState {
  List<FeedbackQuestion> questions = [];
  FeedbackSuccess(this.questions);

  int get questionsQuantity => questions.length;
}

class FeedbackQuestion {
  final String questionTemplate;
  final String contextTarget;

  const FeedbackQuestion({this.questionTemplate = '', this.contextTarget = ''});

  FeedbackQuestion.fromJson(Map json)
      : this.questionTemplate = json["template"],
        this.contextTarget = json["target"];
}
