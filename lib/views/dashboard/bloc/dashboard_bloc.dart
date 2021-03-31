import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  ContentRepository contentRepository = ContentRepository();

  DashboardBloc() : super(DashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardInitialise) {
      yield* _mapDashboardInitialiseEventToState();
    }
    if (event is DashboardGetTags) {
      yield* _mapDashboardGetTagsEventToState();
    }
    if (event is DashboardSetTags) {
      yield* _mapDashboardSetTagsEventToState(event);
    }
    if (event is DashboardSelectTag) {
      yield* _mapDashboardSelectTagEventToState(event);
    }
    if (event is DashboardGetFeed) {
      yield* _mapDashboardGetFeedEventToState(event);
    }
    if (event is DashboardSetFeed) {
      yield* _mapDashboardSetFeedEventToState(event);
    }
  }

  Stream<DashboardState> _mapDashboardInitialiseEventToState() async* {
    yield DashboardLoading();
    this.add(DashboardGetTags());
  }

  Stream<DashboardState> _mapDashboardGetTagsEventToState() async* {
    yield DashboardTagsLoading();
    try {
      List<String> _tags = await contentRepository.getTags();
      _tags.shuffle();
      this.add(DashboardSetTags(_tags.getRange(0, 3).toList()));
    } catch (err) {
      yield DashboardLoadingError();
    }
  }

  Stream<DashboardState> _mapDashboardSetTagsEventToState(DashboardSetTags event) async* {
    yield DashboardPreview(tags: event.tags);
  }

  Stream<DashboardState> _mapDashboardSelectTagEventToState(DashboardSelectTag event) async* {
    List<String> _existTags = (state as DashboardPreview).tags;
    yield DashboardPreview(tags: _existTags, selectedTag: event.tag);
    this.add(DashboardGetFeed(event.tag));
  }

  Stream<DashboardState> _mapDashboardGetFeedEventToState(DashboardGetFeed event) async* {
    try {
      List<AumUserPractice> _practices = await contentRepository.getFeed('id', event.tagByFeed);
      DashboardFeed _feed = DashboardFeed(_practices);
      this.add(DashboardSetFeed(_feed));
    } catch (err) {
      yield DashboardLoadingError();
    }
  }

  Stream<DashboardState> _mapDashboardSetFeedEventToState(DashboardSetFeed event) async* {
    List<String> _existTags = (state as DashboardPreview).tags;
    String _existSelectedTag = (state as DashboardPreview).selectedTag;
    yield DashboardPreview(tags: _existTags, selectedTag: _existSelectedTag, feed: event.feed);
  }
}
