abstract class FeedbackState {
  const FeedbackState();
}

class FeedbackIsLoading extends FeedbackState {
  const FeedbackIsLoading();
}

class FeedbackSuccess extends FeedbackState {
  List<FeedbackQuestion> questions = [];
  FeedbackQuestion currentQuestion;
  FeedbackSuccess(this.questions, {this.currentQuestion});

  int get questionsQuantity => questions.length;
  bool get hasNextQuestions =>
      questions.length > (questions.indexWhere((element) => element.id == currentQuestion.id) + 1);
}

class FeedbackQuestion {
  final String id;
  final String questionTemplate;
  final String contextTarget;

  const FeedbackQuestion({this.id = '', this.questionTemplate = '', this.contextTarget = ''});

  FeedbackQuestion.fromJson(Map json)
      : this.id = json["id"],
        this.questionTemplate = json["template"],
        this.contextTarget = json["target"];
}
