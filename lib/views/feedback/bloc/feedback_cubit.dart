import 'package:aum_app_build/data/user_repository.dart';
import 'package:aum_app_build/views/feedback/bloc/feedback_state.dart';
import 'package:bloc/bloc.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  UserRepository _userRepository = UserRepository();
  FeedbackCubit() : super(FeedbackIsLoading());

  Future getPracticeQuestions() async {
    try {
      List<FeedbackQuestion> _questions = await _userRepository.getFeedbackQuestions();
      emit(FeedbackSuccess(_questions));
    } catch (err) {
      print(err);
    }
  }
}
