import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  ContentRepository repository = ContentRepository();

  DashboardBloc() : super(DashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardGetPreview) {
      yield DashboardLoading();
      try {
        Map content = await this.repository.getPreview();
        String fact = await this.repository.getFact();
        firebaseInstance.collection('users').snapshots().listen((data) {
          this.add(DashboardUpdateUsersCount(count: data.docs.length));
        });
        yield DashboardPreview(preview: content, fact: fact);
      } catch (err) {
        print(err);
      }
    } else if (event is DashboardUpdateUsersCount) {
      yield DashboardPreview(
          preview: (state as DashboardPreview).preview,
          fact: (state as DashboardPreview).fact,
          count: event.count);
    }
  }
}
