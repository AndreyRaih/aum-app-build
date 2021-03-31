import 'package:aum_app_build/views/progress/bloc/progress_state.dart';
import 'package:bloc/bloc.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressIsLoading());

  Future getProgressData() {
    emit(ProgressByWeek());
  }
}
