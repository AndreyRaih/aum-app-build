import 'dart:async';
import 'package:aum_app_build/views/progress/bloc/progress_event.dart';
import 'package:aum_app_build/views/progress/bloc/progress_state.dart';
import 'package:bloc/bloc.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressIsLoaded());
  @override
  Stream<ProgressState> mapEventToState(ProgressEvent event) async* {}
}
