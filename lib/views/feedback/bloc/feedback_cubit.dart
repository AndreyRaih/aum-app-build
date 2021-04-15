import 'package:aum_app_build/data/user_repository.dart';
import 'package:aum_app_build/views/feedback/bloc/feedback_state.dart';
import 'package:bloc/bloc.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  UserRepository _userRepository = UserRepository();
  FeedbackCubit() : super(FeedbackIsLoading());

  Future getPracticeQuestions() async {
    try {
      List<FeedbackQuestion> _questions = await _userRepository.getFeedbackQuestions();
      emit(FeedbackSuccess(_questions, currentQuestion: _questions[0]));
    } catch (err) {
      print(err);
    }
  }

  void nextQuestion() {
    final List<FeedbackQuestion> _list = (this.state as FeedbackSuccess).questions;
    int _pos = _list.indexWhere((element) => (this.state as FeedbackSuccess).currentQuestion.id == element.id) + 1;
    emit(FeedbackSuccess(_list, currentQuestion: _list[_pos]));
  }
}
