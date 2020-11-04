import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  ContentRepository repository = ContentRepository();

  DashboardBloc() : super(DashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardGetPreview) {
      yield DashboardLoading();
      try {
        Map content = await this.repository.getPreview();
        yield DashboardPreview(preview: content);
      } catch (err) {
        print(err);
      }
    }
  }
}
