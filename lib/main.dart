import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/views/asana_details/main.dart';
import 'package:aum_app_build/views/feedback/main.dart';
import 'package:aum_app_build/views/login/main.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/main.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/progress/main.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:firebase_core/firebase_core.dart';
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

final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    if (_error) {
      return Container();
    }
    if (_initialized) {
      return BlocProvider<NavigatorBloc>(
          create: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
          child: CupertinoApp(
            initialRoute: '/login',
            navigatorKey: _navigatorKey,
            navigatorObservers: [_routeObserver],
            routes: {
              '/login': (context) => RegistrationScreen(),
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
          ));
    }
  }
}
