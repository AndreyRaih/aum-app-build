import 'package:aum_app_build/views/asana_details/main.dart';
import 'package:aum_app_build/views/feedback/main.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/main.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/progress/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/dashboard/main.dart';
import 'package:aum_app_build/views/practice_preview/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/preview': (context) => BlocProvider(
              create: (context) =>
                  PreviewBloc()..add(InitPreviewDictionaries()),
              child: PreviewScreen(),
            ),
        '/progress': (context) => ProgressScreen(),
        '/asana-detail': (context) => AsanaDetailScreen(),
        '/player': (context) => BlocProvider(
              create: (context) => PlayerBloc(),
              child: PlayerScreen(),
            ),
        '/feedback': (context) => FeedbackScreen()
      },
    );
  }
}
